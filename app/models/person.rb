class Person < ApplicationRecord
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :addresses

  validates_presence_of :f_name, :l_name
  validates :phone ,
            presence:true,
            length: { maximum: 25 }
  validates :email,
            presence: true,
            uniqueness: true,
            length: { maximum: 50 },
            format: { with: VALID_EMAIL }

  accepts_nested_attributes_for :addresses
end
