require "test_helper"

class PromotionTest < ActiveSupport::TestCase

  test "initialize finds existing promotion by id" do
    existing_promotion = promotions(:one)
    promotion = Promotion.get_promotion(id: 1)
    assert_equal existing_promotion.discount_percent, promotion.discount_percent
    assert_equal existing_promotion.condition, promotion.condition
    assert_equal existing_promotion.discount_type, promotion.discount_type
    assert_equal existing_promotion.name, promotion.name
  end

  test "initialize raises error for non-existing promotion id" do
    non_existing_id = 500
    assert_raises ActiveRecord::RecordNotFound do
      Promotion.get_promotion(id: non_existing_id)
    end
  end

  test "initializes SR1" do
    existing_promotion = promotions(:two)
    promotion = Promotion.get_promotion(id: 2)
    assert_equal existing_promotion.discount_percent, promotion.discount_percent
    assert_equal existing_promotion.condition, promotion.condition
    assert_equal existing_promotion.discount_type, promotion.discount_type
    assert_equal existing_promotion.name, promotion.name
  end

  test "fails to initialize when more than one value is passed" do
    assert_raises ArgumentError do
      promotion = Promotion.get_promotion(id: 1, discount_percent: 100.00)
    end
  end

  test "fails to initialize when no value is passed" do
    assert_raises ArgumentError do
      promotion = Promotion.get_promotion()
    end
  end

  test "gets promotions based on product promotion_id" do
    product = Product.get_product(code: "GR1")
    existing_promotion = promotions(:one)
    promotion = Promotion.get_promotion(id: product.promotion_id)

    assert_equal existing_promotion.discount_percent, promotion.discount_percent
    assert_equal existing_promotion.condition, promotion.condition
    assert_equal existing_promotion.discount_type, promotion.discount_type
    assert_equal existing_promotion.name, promotion.name
  end
end
