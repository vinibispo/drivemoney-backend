class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :description, :category, :value, :type
  has_one :account
end
