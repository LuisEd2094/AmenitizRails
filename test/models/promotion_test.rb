require "test_helper"

class PromotionTest < ActiveSupport::TestCase

  test "initialize finds existing promotion by id" do
    existing_promotion = promotions(:one)
    promotion = Promotion.get_promotion(id: 1)
    assert_equal existing_promotion.divisor, promotion.divisor
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
    assert_equal existing_promotion.divisor, promotion.divisor
    assert_equal existing_promotion.condition, promotion.condition
    assert_equal existing_promotion.discount_type, promotion.discount_type
    assert_equal existing_promotion.name, promotion.name
  end

  test "fails to initialize when more than one value is passed" do
    assert_raises ArgumentError do
      promotion = Promotion.get_promotion(id: 1, divisor: 100.00)
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

    assert_equal existing_promotion.divisor, promotion.divisor
    assert_equal existing_promotion.condition, promotion.condition
    assert_equal existing_promotion.discount_type, promotion.discount_type
    assert_equal existing_promotion.name, promotion.name
  end

  def assert_result(expected, price)
    assert_equal expected, price.to_f.truncate(2)
  end

  #EQUAL discount_type tests
  test "check get_discount Equal when promotion doesn't apply" do
    promotion = Promotion.get_promotion(id: 1)
    assert_result(0.0, promotion.get_discount(1, 3.11))
  end

  test "check get_discount Equal when promotion applies" do
    promotion = Promotion.get_promotion(id: 1)
    assert_result(3.11, promotion.get_discount(2, 3.11))


  end

  test "check get_discount Equal when promotion applies more than once" do
    promotion = Promotion.get_promotion(id: 1)
    assert_result(6.22, promotion.get_discount(4, 3.11))


  end

  test "check get_discount Equal when promotion applies more than once but uneven" do
    promotion = Promotion.get_promotion(id: 1)
    assert_result(3.11, promotion.get_discount(3, 3.11))

  end

  #GREATER discount_type test 10%

  test "check GREATER type 10% doesn't apply" do
    promotion = Promotion.get_promotion(id: 2)
    assert_result(0.0, promotion.get_discount(1, 5))

  end

  test "check GREATER type 10% applies" do
    promotion = Promotion.get_promotion(id: 2)
    assert_result(1.5, promotion.get_discount(3, 5))

  end

  test "check GREATER type 10% applies more than once" do
    promotion = Promotion.get_promotion(id: 2)
    assert_result(2.0, promotion.get_discount(4, 5))


  end

  #GREATER discount_type test 33%

  test "check GREATER type 33% doesn't apply" do
    promotion = Promotion.get_promotion(id: 3)
    assert_result(0.0, promotion.get_discount(1, 11.23))

  end

  test "check GREATER type 33% applies" do
    promotion = Promotion.get_promotion(id: 3)

    assert_result((11.23), promotion.get_discount(3, 11.23))

  end

  test "check GREATER type 33% applies 4 times" do
    promotion = Promotion.get_promotion(id: 3)
    assert_result((14.97), promotion.get_discount(4, 11.23))


  end

  test "check GREATER type 33% applies 5 times" do
    promotion = Promotion.get_promotion(id: 3)
    assert_result((18.71), promotion.get_discount(5, 11.23))

  end

  test "check GREATER type 33% applies 6 times" do
    promotion = Promotion.get_promotion(id: 3)
    assert_result((22.46), promotion.get_discount(6, 11.23))

  end
end
