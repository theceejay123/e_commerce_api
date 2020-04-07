ActiveAdmin.register Product do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :price, :photographer_id, :category_id, :prod_image

  controller do
    def scoped_collection
      super.includes :photographer, :category # prevents N+1 queries to your database
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :photographer
    column :category
    column "Image" do |product|
      image_tag product.prod_image, size: "50x50"
    end
    actions
  end

  # Formtastic
  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :prod_image, as: :file
    end
    f.actions
  end
end
