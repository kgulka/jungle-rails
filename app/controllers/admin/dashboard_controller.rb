class Admin::DashboardController < Admin::AdminController
  def show
    @store_product_count = Product.all.count
    @store_category_count = Category.all.count
  end
end
