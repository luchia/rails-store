class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  skip_before_action :authorise

  def index
  	@products = Product.order(:name)
  end
end
