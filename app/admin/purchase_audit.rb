ActiveAdmin.register_page "PurchaseAudit" do
  menu priority: 10, label: "Purchase Audit"

  content title: "Purchase Audit" do
    div class: "purchase_audit_container", id: "purchase_audit_container" do
      link_to "Come Here", purchase_audit_path(format: :csv)
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
