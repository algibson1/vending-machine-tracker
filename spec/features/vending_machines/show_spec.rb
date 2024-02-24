require 'rails_helper'

RSpec.describe 'When a user visits a vending machine show page', type: :feature do
  before do
    @owner = Owner.create(name: "Sam's Snacks")
    @dons  = @owner.machines.create(location: "Don's Mixed Drinks")
    @cheetos = Snack.create!(name: "Cheetos", price: 2.00)
    @burger = Snack.create!(name: "White Castle Burger", price: 3.50)
    @pop_rocks = Snack.create!(name: "Pop Rocks", price: 1.50)
    @charles = @owner.machines.create!(location: "Charles' Bar")
  end

  scenario 'they see the location of that machine' do
    visit machine_path(@dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end

  it "they see the name of all snacks associated with that vending machine and their price" do
    #     User Story 1 of 3
    @dons.snacks << [@cheetos, @burger, @pop_rocks]

    # As a visitor
    # When I visit a vending machine show page
    visit machine_path(@dons)
    # I see the name of all of the snacks associated with that vending machine along with their price
    # and I also see an average price for all of the snacks in that machine. 

    # Example:
    # Don's Mixed Drinks
    expect(page).to have_content("Don's Mixed Drinks")
    #   Snacks
    expect(page).to have_content("Snacks")
    #     * White Castle Burger: $3.50
    expect(page).to have_content("* White Castle Burger: $3.50")
    #     * Pop Rocks: $1.50
    expect(page).to have_content("* Pop Rocks: $1.50")
    #     * Flaming Hot Cheetos: $2.50
    expect(page).to have_content("* Cheetos: $2.00")
    #   Average Price: $2.50
    expect(page).to have_content("Average Price: $2.33")
  end

  it "has a form to add a snack to the machine" do 
    #     User Story 2 of 3
    # ​
    # As a visitor
    # When I visit a vending machine show page
    visit machine_path(@dons)
    # I see a form to add an existing snack to that vending machine
    expect(page).to_not have_content(@pop_rocks.name)
    expect(page).to have_field(:snack_id)
    # When I fill in the form with the ID of a snack that already exists in the database
    fill_in(:snack_id, with: @pop_rocks.id)
    # And I click Submit
    click_button("Submit")
    # Then I am redirected to that vending machine's show page
    expect(current_path).to eq(machine_path(@dons))
    # And I see that snack is now listed. 
    expect(page).to have_content(@pop_rocks.name)
  end

  it "removes a snack from the machine" do 
    # As a visitor
    # When I visit a vending machine show page
    @dons.snacks << [@cheetos, @burger, @pop_rocks]
    @charles.snacks << [@pop_rocks, @burger]

    visit machine_path(@dons)
    expect(page).to have_content(@pop_rocks.name)
    save_and_open_page
    # I see a button (or link) next to each snack that says "Remove Snack"
    @dons.snacks.each do |snack|
      within("#snack-#{snack.id}") do 
        expect(page).to have_button("Remove Snack")
      end
    end
    # When I click that button,
    within("#snack-#{@pop_rocks.id}") do
      click_button("Remove Snack")
    end
    # I am redirected to this vending machine's show page
    expect(current_path).to eq(machine_path(@dons))
    # And I no longer see that snack listed on this page
    expect(page).to_not have_content(@pop_rocks.name)
    # And when I visit a different vending machine's show page that also has that snack
    visit machine_path(@charles)
    # I still see that snack listed. 
    expect(page).to have_content(@pop_rocks.name)
  end
end
