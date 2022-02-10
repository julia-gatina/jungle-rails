require 'rails_helper'

RSpec.feature "AddToCart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

    scenario "visit the home page and click 'Add to Cart' buttons for one of the products" do
      visit root_path
      expect(page).to have_text 'My Cart (0)', count: 1
      
      first('.product').click_on('Add')
  
      expect(page).to have_text 'My Cart (1)', count: 1

      save_and_open_screenshot
    end
  end

