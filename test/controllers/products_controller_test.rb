require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
	setup do
		@product = products(:one)
		@product_update = {
			name: 'Test Product',
			summary: 'Test Product Description',
			image_url: 'test_product.jpg',
			price: 9.95
		}
	end

	test "should create product" do
		assert_difference('Product.count') do
			post :create, product: @product_update
		end
		assert_redirected_to product_path(assigns(:product))
	end

	test "should update product" do
		patch :update, id: @product, product: @product_update
		assert_redirected_to product_path(assigns(:product))
	end

	test "should destroy product" do
		assert_difference('Product.count', -1) do
			delete :destroy, id: @product
		end
		assert_redirected_to products_path
	end
end