require 'rails_helper'

RSpec.describe Snack, type: :model do
  describe "relationships" do
    it { should have_many :machine_snacks }
    it { should have_many(:machines).through :machine_snacks }
  end

  describe "model methods" do
    it "formats price to two decimal places" do
      @cheetos = Snack.create!(name: "Cheetos", price: 2.00)
      @burger = Snack.create!(name: "White Castle Burger", price: 3.50)
      @pop_rocks = Snack.create!(name: "Pop Rocks", price: 1.50)

      expect(@cheetos.format_price).to eq("$2.00")
      expect(@burger.format_price).to eq("$3.50")
      expect(@pop_rocks.format_price).to eq("$1.50")
    end
  end
end
