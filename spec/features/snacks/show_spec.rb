require "rails_helper" 

RSpec.describe "Snack show page" do
  before do 
    @owner = Owner.create(name: "Sam's Snacks")
    @dons  = @owner.machines.create(location: "Don's Mixed Drinks")
    @charles = @owner.machines.create!(location: "Charles' Bar")
    @cheetos = Snack.create!(name: "Cheetos", price: 2.00)
    @burger = Snack.create!(name: "White Castle Burger", price: 3.50)
    @pop_rocks = Snack.create!(name: "Pop Rocks", price: 1.50)
    @dons.snacks << [@cheetos, @burger, @pop_rocks]
    @charles.snacks << [@pop_rocks, @burger]
  end

  it "has name of snack, price, locations, and details about those machines" do
    #     User Story 3 of 3

    # As a visitor
    # When I visit a snack show page
    visit snack_path(@pop_rocks)
    # I see the name of that snack
    expect(page).to have_content(@pop_rocks.name)
    #   and I see the price for that snack
    expect(page).to have_content("Price: $1.50")
    #   and I see a list of locations with vending machines that carry that snack
    expect(page).to have_content("Locations")
    #   and I see the average price for snacks in those vending machines
    #   and I see a count of the different kinds of items in that vending machine.

    # ​Example: 

    # Flaming Hot Cheetos
    #   Price: $2.50
    #   Locations
    #     * Don's Mixed Drinks (3 kinds of snacks, average price of $2.50)
    expect(page).to have_content("Don's Mixed Drinks (3 kinds of snacks, average price of $2.33)")
    #     * Turing Basement (2 kinds of snacks, average price of $3.00)
    expect(page).to have_content("Charles' Bar (2 kinds of snacks, average price of $2.50)")
    save_and_open_page
  end
end