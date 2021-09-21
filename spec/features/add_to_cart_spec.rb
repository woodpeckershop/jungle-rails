require 'rails_helper'

RSpec.feature "Visitor adds item to cart", type: :feature, js: true do

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
    scenario "add an item to cart and the cart count increments" do
      visit root_path
  
      first('article.product').click_on('Add')
      
      expect(page).to have_text 'My Cart (1)'
  
      save_and_open_screenshot
      
    end
end
