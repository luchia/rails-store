require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
	fixtures :products

	test "buy a product successfully" do
		LineItem.delete_all
		Order.delete_all
		pencil_set = products(:ruby)

		get '/'
		assert_response :success
		assert_template 'index'

		xml_http_request :post, '/line_items', product_id: pencil_set.id
		assert_response :success
		cart = Cart.find(session[:cart_id])
		assert_equal 1, cart.line_items.size
		assert_equal pencil_set, cart.line_items[0].product

		get '/orders/new'
		assert_response :success
		assert_template 'new'

		post_via_redirect '/orders', order: { name: 'Rick James', address: '34 James Street', email: 'rick@james.com', payment_method: 'Credit Card' }
		assert_response :success
		assert_template 'index'
		cart = Cart.find(session[:cart_id])
		assert_equal 0, cart.line_items.size

		orders = Order.all
		assert_equal 1, orders.size
		order = orders[0]

		assert_equal 'Rick James', order.name
		assert_equal '34 James Street', order.address
		assert_equal 'rick@james.com', order.email
		assert_equal 'Credit Card', order.payment_method

		assert_equal 1, order.line_items.size
		line_item = order.line_items[0]
		assert_equal pencil_set, line_item.product

		mail = ActionMailer::Base.deliveries.last
		assert_equal ["rick@james.com"], mail.to
		assert_equal 'The Shop <user@gmail.com>', mail[:from].value
		assert_equal 'The Shop - Order Confirmation', mail.subject

	end
end
