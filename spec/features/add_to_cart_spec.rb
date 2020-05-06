require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end


  scenario "They see the cart being increased by 1 when adding an item" do
    # ACT
    visit root_path
    expect(page).to have_content('My Cart (0)')
    click_button 'Add', match: :first
    # DEBUG / VERIFY
    save_screenshot('MyCart.png')
    expect(page).to have_content('My Cart (1)')
  end
end
