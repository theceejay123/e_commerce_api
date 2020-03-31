# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :set_page, only: %i[show edit update destroy]

  # GET /pages.json
  def index
    @pages = Page.all
  end

  # GET /pages/1.json
  def show; end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit; end

  # POST /pages.json
  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.json { render :show, status: :created, location: @page }
      else
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        format.json { render :show, status: :ok, location: @page }
      else
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = Page.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def page_params
    params.require(:page).permit(:title, :content, :permalink)
  end
end
