ActiveAdmin.register_page "DailyRevenueReport" do
  menu priority: 9, label: "Daily Revenue Report"

  content title: "Daily Revenue Report" do
    div class: "revenue_report_container", id: "revenue_report_container" do
      link_to "Come Here", daily_revenue_report_path
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
