ActiveAdmin.register Product do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :price, :photographer_id, :category_id, :prod_image

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
