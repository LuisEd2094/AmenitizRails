require "test_helper"

class ProductTest < ActiveSupport::TestCase
  
  test "initialize finds existing product by code" do
      existing_product = products(:one)
      product = Product.get_product(code: "GR1")
      assert_equal existing_product.name, product.name
      assert_equal existing_product.price, product.price
      assert_equal existing_product.promotion_id, product.promotion_id
  end

  test "initialize raises error for non-existing product code" do
    non_existing_code = "NONEXISTENT"
    assert_raises ActiveRecord::RecordNotFound do
      Product.get_product(code: non_existing_code)
    end
  end

  test "initializes SR1" do
    existing_product = products(:two)
    product = Product.get_product(code: "SR1")
    assert_equal existing_product.name, product.name
    assert_equal existing_product.price, product.price
    assert_equal existing_product.promotion_id, product.promotion_id
  end
  test "failst to initialize when more than one value is passed" do
    assert_raises ArgumentError do
      product = Product.get_product(code: "SR1", name: "Strawberry")
    end
  end

  test "failst to initialize when no value is passed" do
    assert_raises ArgumentError do
      product = Product.get_product()
    end
  end
end