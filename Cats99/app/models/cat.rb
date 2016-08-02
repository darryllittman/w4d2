class Cat < ActiveRecord::Base
  validates :birth_date, :name, :sex, :color, :description, presence: true
  validates :sex, inclusion: { in: %w(M F),
    message: "%{sex} is not a valid sex"}

    
end
