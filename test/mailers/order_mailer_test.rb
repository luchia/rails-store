require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received(orders(:one))
    assert_equal 'The Shop - Order Confirmation', mail.subject
    assert_equal ['rick@james.com'], mail.to
    assert_equal ['user@gmail.com'], mail.from
    assert_match /1 x Pencil Set/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderMailer.shipped(orders(:one))
    assert_equal 'The Shop - Order Shipped', mail.subject
    assert_equal ['rick@james.com'], mail.to
    assert_equal ['user@gmail.com'], mail.from
    assert_match /1 x Pencil Set/, mail.body.encoded
  end
end
