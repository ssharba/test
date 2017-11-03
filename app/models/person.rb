class Person < ApplicationRecord
  has_many :addresses
  validates_presence_of :f_name, :l_name, :phone, :email
  accepts_nested_attributes_for :addresses
end
