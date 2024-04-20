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


  #EQUAL discount_type tests
  test "check get_discount Equal when promotion doesn't apply" do
    promotion = Promotion.get_promotion(id: 1)

    assert_equal promotion.get_discount(1, 5.00), 0.0
  end

  test "check get_discount Equal when promotion applies" do
    promotion = Promotion.get_promotion(id: 1)

    assert_equal promotion.get_discount(2, 5.00), 5.00

  end

  test "check get_discount Equal when promotion applies more than once" do
    promotion = Promotion.get_promotion(id: 1)

    assert_equal promotion.get_discount(4, 5.00), 10.00

  end

  test "check get_discount Equal when promotion applies more than once but uneven" do
    promotion = Promotion.get_promotion(id: 1)

    assert_equal promotion.get_discount(3, 5.00), 5.00

  end

  #GREATER discount_type test 10%

  test "check GREATER type 10% doesn't apply" do
    promotion = Promotion.get_promotion(id: 2)

    assert_equal promotion.get_discount(1, 5.00), 0.0
  end

  test "check GREATER type 10% applies" do
    promotion = Promotion.get_promotion(id: 2)

    assert_equal promotion.get_discount(3, 5.00), (5.00 * 3 * 0.10).round(2)
  end

  test "check GREATER type 10% applies more than once" do
    promotion = Promotion.get_promotion(id: 2)

    assert_equal promotion.get_discount(4, 5.00), (5.00 * 4.0 * 0.10).round(2)

  end

  test "check GREATER type 10% applies more than once but uneven" do
    promotion = Promotion.get_promotion(id: 2)

    assert_equal promotion.get_discount(3, 5.00), (5.00 * 3.0 * 0.10).round(2)

  end


  #GREATER discount_type test 33%

  test "check GREATER type 33% doesn't apply" do
    promotion = Promotion.get_promotion(id: 3)

    assert_equal promotion.get_discount(1, 5.00), 0.0
  end

  test "check GREATER type 33% applies" do
    promotion = Promotion.get_promotion(id: 3)

    assert_equal promotion.get_discount(3, 5.00), (5.00 * 3 * 0.3333).round(2)
  end

  test "check GREATER type 33% applies more than once" do
    promotion = Promotion.get_promotion(id: 3)

    assert_equal promotion.get_discount(4, 5.00), (5.00 * 4.0 * 0.3333).round(2)

  end

  test "check GREATER type 33% applies more than once but uneven" do
    promotion = Promotion.get_promotion(id: 3)

    assert_equal promotion.get_discount(3, 5.00), (5.00 * 3.0 * 0.3333).round(2)
  end


end
