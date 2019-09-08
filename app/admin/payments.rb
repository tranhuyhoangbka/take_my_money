ActiveAdmin.register Payment do
  filter :reference
  filter :price
  filter :status
  filter :payment_method
  filter :created_at

  index do
    selectable_column
    id_column
    column :reference
    column :user
    column :price
    column :status
    column :payment_method
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :reference
      row :price
      row :status
      row :payment_method
      row :user
      row :created_at
      row :response_id
      row :full_response
    end
    active_admin_comments
  end

  csv do
    column :reference
    column(:date){|payment| payment.created_at.to_s(:sql)}
    column(:user_email){|payment| payment.user.email}
    column(:price)
    column(:status)
    column(:payment_method)
    column(:response_id)
    column(:discount)
  end

  action_item :refund, only: :show do
    link_to("Refund Payment", refund_path(id: payment.id, type: Payment), method: :post, class: "button", data: {confirm: "Are you sure you want refund this payment?"})
  end
end
