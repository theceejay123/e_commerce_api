require "nokogiri"
require "httparty"
require "byebug"

class Scraper
  def scrape_photographers
    photographer_url = "https://www.pocket-lint.com/apps/news/instagram/131470-incredible-photographers-to-follow-on-instagram-right-now"
    # The HTTParty method takes in our URL string, and returns the HTML from that page.
    unparsed = HTTParty.get(photographer_url)
    # Nokogiri's HTML method then takes in our html arguement, and returns to us a set of nodes
    parsed = Nokogiri::HTML(unparsed)

    photographers = []
    photographer_listings = parsed.css(".text-content").css(".nolinks2")
    photographer_descriptions = parsed.css(".text-content").css("p")
    photographer_listings.each.with_index do |photographer_listing, index|
      photographer = {
        name:        photographer_listing.text,
        description: photographer_descriptions[index + 4].text
      }

      photographers << photographer
    end

    photographers
  end

  def scrape_taxes_by_province
    taxes_url = "http://www.calculconversion.com/sales-tax-calculator-hst-gst.html"
    unparsed = HTTParty.get(taxes_url)
    parsed = Nokogiri::HTML(unparsed)

    taxes = []
    tax_listings = parsed.css(".text_calcul").css("table").css("tr")
    tax_listings.each.with_index do |tax_listing, index|
      if index != 0
        tax_by_province = {
          province:  tax_listing.css("th").text,
          tax_names: tax_listing.css("td")[0].text.split("+"),
          prov_tax:  tax_listing.css("td")[1].text.strip.sub("%", "").to_i,
          govt_tax:  tax_listing.css("td")[2].text.strip.sub("%", "").to_i
        }

        taxes << tax_by_province
      end
    end

    taxes
  end

  def scrape_categories
    categories_url = "https://www.stocksy.com/blog/types-of-photography/"
    unparsed = HTTParty.get(categories_url)
    parsed = Nokogiri::HTML(unparsed)

    categories = []
    category_listings = parsed.css("div.col-md-6").css("div.margin-bottom-lg:not(.image-block)")
    category_listings.each.with_index do |category_listing, index|
      if index != 0 && index != (category_listings.count - 1)
        category = {
          name:        category_listing.css("h3").text,
          description: category_listing.css("p")[0].text
        }
        categories << category
      end
    end

    categories
  end
end
