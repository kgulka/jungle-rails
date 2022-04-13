require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
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
  scenario "They see the cart count go up on product Add click " do
    # ACT
    visit root_path

    within first('.product') do
      click_on 'Add'
    end

    #wait for the page to get the right snapshot.
    sleep(1)

    # DEBUG 
    save_screenshot
    
    #VERIFY
    expect(page).to have_content 'My Cart (1)'
  end
end