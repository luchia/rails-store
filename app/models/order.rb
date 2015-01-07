class Order < ActiveRecord::Base
	has_many :line_items, dependent: :destroy
	PAYMENT_METHODS = [ "Direct Debit", "Credit Card", "PayPal" ]

	validates :name, :address, :email, presence: true
	validates :payment_method, inclusion: PAYMENT_METHODS

	def add_line_items_from_cart(cart)
		cart.line_items.each do |item|
			item.cart_id = nil
			line_items << item
		end
	end
end
