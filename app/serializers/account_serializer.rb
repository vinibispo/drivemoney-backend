class AccountSerializer < ActiveModel::Serializer
  attributes :id, :name, :initial_value, :active
  has_one :user
end
