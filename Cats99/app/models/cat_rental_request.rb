class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED),
      message: "This is not a valid status" }

  belongs_to :cat

  def overlapping_requests
    cat = Cat.find_by(id: self.cat_id)
    data = cat.cat_rental_requests
    s = self.start_date
    e = self.end_date
    requests = data.select do |datum|
      next if datum.id == self.id
      datum.start_date.between?(s, e) || datum.end_date.between?(s, e) || s.between?(datum.start_date, datum.end_date)
    end
  end

  def overlapping_approved_requests
    overlapping_requests.select {|request| request.status == "APPROVED"}
  end

  def overlapping_pending_requests
    overlapping_requests.select {|request| request.status == "PENDING"}
  end

  def approve!
    requests = overlapping_approved_requests + overlapping_pending_requests

    ActiveRecord::Base.transaction do
      self.update(status: "APPROVED")
      requests.each do |request|
        request.deny!
      end
    end
  end

  def deny!
    self.update(status: "DENIED")
  end

  def pending?
  end

end
