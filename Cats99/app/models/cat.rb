class Cat < ActiveRecord::Base
  validates :birth_date, :name, :sex, :color, :description, presence: true
  validates :sex, inclusion: { in: %w(M F)}

  has_many :cat_rental_requests, :dependent => :destroy

end
