require "test_helper"

class CartControllerTest < ActionDispatch::IntegrationTest
  
  test "should add product to cart with valid product" do
    product = products(:one) 
    
    post "/add_to_cart", params: { product_code: product.code, quantity: 2 }, as: :json
    
    assert_response :success
    #assert_includes response.parsed_body["cart"]["items"], { "product_code" => product.id, "quantity" => 2 }
  end
  
  test "should return error with invalid product" do
    post "/add_to_cart", params: { product_code: 999, quantity: 2 }, as: :json
    
    assert_response :not_found
    #assert_equal "Product not found", response.parsed_body["error"]
  end


  test "validate if the prices in response are correct" do
    product = products(:one) 
    
    post "/add_to_cart", params: { product_code: product.code, quantity: 2 }, as: :json
    assert_response :success

    response_json = JSON.parse(response.body)
    assert_equal "Item added to cart successfully", response_json["message"]
    assert_equal true, response_json["success"]
    assert_includes response_json, "has_discount"
    assert_includes response_json, "discount_amount"
    assert_includes response_json, "total"

    # Assuming you have calculated the expected values for has_discount, discount_amount, and total
    expected_has_discount = true
    expected_discount_amount = product.price
    expected_total = product.price
    assert_equal expected_has_discount, response_json["has_discount"]
    assert_equal expected_discount_amount, response_json["discount_amount"]
    assert_equal expected_total, response_json["total"]

  end
end
