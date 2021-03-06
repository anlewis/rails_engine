class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices

  def self.search(params)
    case
      when params["id"]
        Customer.find_by(id: params["id"].to_i)
      when params["first_name"]
        Customer.find_by(first_name: params["first_name"])
      when params["last_name"]
        Customer.find_by(last_name: params["last_name"])
      when params["created_at"]
        Customer.find_by(created_at: params["created_at"].to_datetime)
      when params["updated_at"]
        Customer.find_by(updated_at: params["updated_at"].to_datetime)
      when params
        Customer.find_by(id: rand(1..Customer.count))
    end
  end

  def self.search_all(params)
    case
      when params["id"]
        Customer.where(id: params["id"].to_i)
      when params["first_name"]
        Customer.where(first_name: params["first_name"])
      when params["last_name"]
        Customer.where(last_name: params["last_name"])
      when params["created_at"]
        Customer.where(created_at: params["created_at"].to_datetime)
      when params["updated_at"]
        Customer.where(updated_at: params["updated_at"].to_datetime)
    end
  end

  def self.favorite_merchant(customer_id)
    find(customer_id)
    .merchants
    .select("merchants.*, count(transactions)")
    .joins(invoices: :transactions)
    .merge(Transaction.unscoped.successful)
    .group("merchants.id")
    .order("count DESC")
    .first
  end
end
