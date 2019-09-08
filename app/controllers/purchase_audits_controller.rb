class PurchaseAuditsController < ApplicationController
  def show
    respond_to do |format|
      format.csv do
        headers["X-Accel-Buffering"] = "no"
        headers["Cache-Control"] = "no-cache"
        headers["Content-Type"] = "text/csv; charset=utf-8"
        headers["Content-Disposition"] = %(attachment; filename="purchase_audit.csv")
        headers["Last-Modified"] = Time.zone.now.ctime.to_s
        self.response_body = PurchaseAudit.to_csv_enumerator
      end
    end
  end
end