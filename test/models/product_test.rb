require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products

	test "product attributes must not be empty" do
		product = Product.new
		assert product.invalid?
		assert product.errors[:name].any?
		assert product.errors[:summary].any?
		assert product.errors[:price].any?
		assert product.errors[:image_url].any?
	end

	test "product price must be positive" do
		product = Product.new(name: 'Ruler', summary: 'Ruler description', image_url: 'ruler.jpg')
		product.price = -1
		assert product.invalid?
		assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

		product.price = 0
		assert product.invalid?
		assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

		product.price = 1
		assert product.valid?
	end

	def new_product(image_url)
		Product.new(name: 'Eraser', summary: 'Eraser description', price: 1, image_url: image_url)
	end

	test "image url" do
		ok = %w{ eraser.gif eraser.jpg eraser.png ERASER.JPG ERASER.Jpg http://a.b/c/d/eraser.gif }
		bad = %w{ eraser.doc eraser.gif/plus eraser.gif.plus }

		ok.each do |name|
			assert new_product(name).valid?, "#{name} should be valid"
		end

		bad.each do |name|
			assert new_product(name).invalid?, "#{name} shouldn't be valid"
		end
	end

	test "product is not valid without a unique name" do
		product = Product.new( name: products(:ruby).name, summary: "yyy", price: 1, image_url: "fred.gif")

		assert product.invalid?
		assert_equal ["has already been taken"], product.errors[:name]
	end
end
