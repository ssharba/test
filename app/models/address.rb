class Address < ApplicationRecord
  belongs_to :person, optional: true
  validates_presence_of :line1, :line2, :city, :state, :zip
end
