class PersonSerializer < ActiveModel::Serializer
  attributes :id, :f_name, :l_name, :phone, :email
  has_many :addresses
end
