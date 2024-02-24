require "rails_helper"

RSpec.describe Machine, type: :model do
  describe "validations" do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
  end

  describe "relationships" do
    it { should have_many :machine_snacks }
    it { should have_many(:snacks).through(:machine_snacks)}
  end

  describe "model methods" do
    it "returns average price of all snacks" do
      @owner = Owner.create(name: "Sam's Snacks")
      @dons  = @owner.machines.create(location: "Don's Mixed Drinks")
      @cheetos = Snack.create!(name: "Cheetos", price: 2.00)
      @burger = Snack.create!(name: "White Castle Burger", price: 3.50)
      @pop_rocks = Snack.create!(name: "Pop Rocks", price: 1.50)
      @dons.snacks << [@cheetos, @burger, @pop_rocks]

      @charles = @owner.machines.create!(location: "Some location")
      @charles.snacks << [@cheetos, @burger]

      expect(@dons.average_snack_price).to eq("$2.33")
      expect(@charles.average_snack_price).to eq("$2.75")
    end

    it "counts snacks" do
      @owner = Owner.create(name: "Sam's Snacks")
      @dons  = @owner.machines.create(location: "Don's Mixed Drinks")
      @cheetos = Snack.create!(name: "Cheetos", price: 2.00)
      @burger = Snack.create!(name: "White Castle Burger", price: 3.50)
      @pop_rocks = Snack.create!(name: "Pop Rocks", price: 1.50)
      @dons.snacks << [@cheetos, @burger, @pop_rocks]

      @charles = @owner.machines.create!(location: "Some location")
      @charles.snacks << [@cheetos, @burger]

      expect(@dons.kinds_of_snacks).to eq(3)
      expect(@charles.kinds_of_snacks).to eq(2)
    end
  end
end
