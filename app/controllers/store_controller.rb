class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  skip_before_action :authorise

  def index
  	@products = Product.all.paginate(page: params[:page], per_page: 2)
  end
end
