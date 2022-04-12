require 'rails_helper'
# own @category created and then @product initialized with that category
RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "should create a product with four fields set"  do
      cat = Category.new
      expect(Product.new( name:"Test Prod1", category_id: cat.id, quantity: 10, price: 1000)).to be_a Product
    end

    it "should fail on missing name"  do
      cat = Category.new
      prod = Product.new( category_id: cat.id, quantity: 10, price: 1000)
      prod.validate
      expect(prod.errors.full_messages[0]).to eq("Name can't be blank")
    end
    cat = Category.new
    it "should fail on missing quantity"  do
      prod = Product.new( name:"Test Prod3", category_id: cat.id, price: 1000)
      prod.validate
      expect(prod.errors.full_messages[0]).to eq("Quantity can't be blank")
    end
    cat = Category.new
    it "should fail on missing price"  do
      prod = Product.new( name:"Test Prod3", category_id: cat.id, quantity: 10)
      prod.validate
      expect(prod.errors.full_messages[0]).to eq("Price cents is not a number")
    end
    it "should fail on missing category"  do
      prod = Product.new( name:"Test Prod4", quantity: 10, price: 1001)
      prod.validate
      expect(prod.errors.full_messages[0]).to eq("Category can't be blank")
    end


  end

end
