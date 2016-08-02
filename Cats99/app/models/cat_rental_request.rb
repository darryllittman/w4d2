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
    # where_string = "start_date <= ? OR end_date >= ? OR (start_date <= ? AND end_date >= ?)"
    requests = data.select {|datum| datum.start_date.between?(s, e) || datum.end_date.between?(s, e) || s.between?(datum.start_date, datum.end_date)}
  end

  def overlapping_approved_requests

  end

end
