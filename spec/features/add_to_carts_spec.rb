require 'rails_helper'

RSpec.feature "Add to card", type: :feature do
    # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'
      @product = Product.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99,
        category: @category,
        image: open_asset('apparel1.jpg')
      )

  end

  scenario 'when clicking on add to cart the addtoCart on the navbar increases by 1' do
    visit root_path

    click_on "Add"

    expect(page).to have_content 'My Cart (1)'
  end
  scenario 'addtoCart on the navbar to be 0' do
    visit root_path
    expect(page).to have_content 'My Cart (0)'
  end
end
