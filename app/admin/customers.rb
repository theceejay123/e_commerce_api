ActiveAdmin.register Customer do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :first_name, :last_name, :email, :address, :phone_number, :province_id, :cust_image, :password_digest

  # Formtastic
  form do |f|
    f.semantic_errors
    f.inputs
    f.inputs do
      f.input :cust_image, as: :file
    end
    f.actions
  end
end
