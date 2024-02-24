class Snack < ApplicationRecord
  has_many :machine_snacks 
  has_many :machines, through: :machine_snacks

  def format_price 
    sprintf("$%2.2f", price)
  end
end
