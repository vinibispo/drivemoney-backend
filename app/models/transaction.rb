class Transaction < ApplicationRecord
  belongs_to :account
  enum status: [:income, :outcome]
  validates_presence_of :description, :category, :value

  def self.total_income; income.sum(:value); end
  def self.total_outcome; outcome.sum(:value); end
end
