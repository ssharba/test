class Person < ApplicationRecord
  # has_many :addresses
  # validates_presence_of :f_name, :l_name, :phone, :email
  has_many :address
  validates :f_name, length: { minimum: 2, maximum: 25  }, presence: true
  validates :l_name, length: { minimum: 2, maximum: 25 }, presence: true
  validates :phone, :presence true, :length => { :minimum => 9, :maximum => 10 }, uniqueness: true
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: true

  accepts_nested_attributes_for :addresses
end
