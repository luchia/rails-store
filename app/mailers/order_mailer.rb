class OrderMailer < ActionMailer::Base
  default from: "The Shop <user@gmail.com>"

  def received(order)
    @order = order
    mail to: order.email, subject: 'The Shop - Order Confirmation'
  end

  def shipped(order)
    @order = order
    mail to: order.email, subject: 'The Shop - Order Shipped'
  end
end
