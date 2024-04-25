require "test_helper"

class CartControllerTest < ActionDispatch::IntegrationTest
  
  test "should add product to cart with valid product" do
    product = products(:one) 
    
    post "/add_to_cart", params: {cart: {products: [{product_code: product.code, quantity: 2}]}}, as: :json
    
    assert_response :success
    #assert_includes response.parsed_body["cart"]["items"], { "product_code" => product.id, "quantity" => 2 }
  end
  
  test "should return error with invalid product" do
    post "/add_to_cart", params: {cart: {products: [{ product_code: "aaa", quantity: 2 }]}}, as: :json
    
    assert_response :not_found
    #assert_equal "Product not found", response.parsed_body["error"]
  end


  test "validate if the prices in response are correct" do
    product = products(:one) 
    
    post "/add_to_cart", params: {cart: {products: [{product_code: product.code, quantity: 2}]} }, as: :json
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
    assert_equal expected_discount_amount.to_s, response_json["discount_amount"]
    assert_equal expected_total.to_s, response_json["total"]

  end

  def assert_prices(expected_total, expected_discount, expected_has_discount, params)
    post "/add_to_cart", params: params, as: :json

    assert_response :success
    response_json = JSON.parse(response.body)
    assert_equal expected_has_discount, response_json["has_discount"]
    assert_equal expected_discount.to_s, response_json["discount_amount"]
    assert_equal expected_total.to_s, response_json["total"]
  end


  test "2x1" do
    params = {cart: {
        products: [{product_code: "GR1", quantity: 1}]
      }
    }
    assert_prices(products(:one).price, 0.00, false, params)

    params = {cart: {
      products: [{product_code: "GR1", quantity: 2}]
      }
    }
    assert_prices(products(:one).price, products(:one).price, true, params)

    params = {cart: {
      products: [{product_code: "GR1", quantity: 3}]
      }
    }
    assert_prices(6.22, products(:one).price, true, params)

    params = {cart: {
      products: [{product_code: "GR1", quantity: 4}]
      }
    }
    assert_prices(6.22, 6.22, true, params)

    params = {cart: {
      products: [{product_code: "GR1", quantity: 5}]
      }
    }
    assert_prices(9.33, 6.22,  true, params)

    params = {cart: {
      products: [{product_code: "GR1", quantity: 6}]
      }
    }
    assert_prices(9.33, 9.33, true, params)

    params = {cart: {
      products: [{product_code: "GR1", quantity: 7}]
      }
    }
    assert_prices(12.44, 9.33, true, params)

    params = {cart: {
      products: [{product_code: "GR1", quantity: 9999}]
      }
    }
    assert_prices(15550.0, 15546.89, true, params)

  end

  test "10% discount after 3rd unit" do
    params = {cart: {
      products: [{product_code: "SR1", quantity: 1}]
      }
    }
    assert_prices(5.00, 0.0, false, params)

    params = {cart: {
      products: [{product_code: "SR1", quantity: 2}]
      }
    }
    assert_prices(10.00, 0.0, false, params)


    params = {cart: {
      products: [{product_code: "SR1", quantity: 3}]
      }
    }
    assert_prices(13.5, 1.5, true, params)


    params = {cart: {
      products: [{product_code: "SR1", quantity: 4}]
      }
    }
    assert_prices(18.0, 2.0 , true, params)


    params = {cart: {
      products: [{product_code: "SR1", quantity: 5}]
      }
    }
    assert_prices(22.5, 2.5 , true, params)

    params = {cart: {
      products: [{product_code: "SR1", quantity: 9999}]
      }
    }
    assert_prices(44995.5, 4999.5, true, params)

  
  end

  
  test "2/3 discount after 3rd unit" do
    params = {cart: {
      products: [{product_code: "CF1", quantity: 1}]
      }
    }
    assert_prices(11.23, 0.0, false, params)

    params = {cart: {
      products: [{product_code: "CF1", quantity: 2}]
      }
    }
    assert_prices(22.46, 0.0, false, params)


    params = {cart: {
      products: [{product_code: "CF1", quantity: 3}]
      }
    }
    assert_prices(22.46, 11.23, true, params)


    params = {cart: {
      products: [{product_code: "CF1", quantity: 4}]
      }
    }
    assert_prices(29.94, 14.97 , true, params)


    params = {cart: {
      products: [{product_code: "CF1", quantity: 5}]
      }
    }
    assert_prices(37.43, 18.71 , true, params)

    params = {cart: {
      products: [{product_code: "CF1", quantity: 9999}]
      }
    }
    assert_prices(74859.18, 37429.59, true, params)

  
  end

  test "3x2" do
    params = {cart: {
      products: [{product_code: "CF3", quantity: 2}]
      }
    }
    assert_prices(22.46, 0.00, false, params)


    params = {cart: {
      products: [{product_code: "CF3", quantity: 3}]
      }
    }
    assert_prices(22.46, 11.23, true, params)

    params = {cart: {
      products: [{product_code: "CF3", quantity: 9999}]
      }
    }
    assert_prices(74859.18, 37429.59, true, params)
  end

  test "3x1" do
    params = {cart: {
      products: [{product_code: "CF4", quantity: 2}]
      }
    }
    assert_prices(22.46, 0.00, false, params)


    params = {cart: {
      products: [{product_code: "CF4", quantity: 3}]
      }
    }
    assert_prices(11.23, 22.46, true, params)

    params = {cart: {
      products: [{product_code: "CF4", quantity: 9999}]
      }
    }
    assert_prices(37429.59, 74859.18, true, params)
  end

  test "Coffee_fifth" do
    params = {cart: {
      products: [{product_code: "CF5", quantity: 2}]
      }
    }
    assert_prices(22.46, 0.00, false, params)


    params = {cart: {
      products: [{product_code: "CF5", quantity: 3}]
      }
    }
    assert_prices(26.95, 6.73, true, params)

    params = {cart: {
      products: [{product_code: "CF5", quantity: 9999}]
      }
    }
    assert_prices(89831.01, 22457.75, true, params)
  end

  test "first file example" do
    params = {cart: {
        products: [{product_code: "GR1", quantity: 2}]
      }
    }
    assert_prices(products(:one).price, products(:one).price, true, params)
  end


  test "Second file example" do
    params = {cart: {
        products: [{product_code: "GR1", quantity: 1}, 
        {product_code: "SR1", quantity: 3}]
      }
    }
    assert_prices(16.61, 1.5, true, params)
  end



  test "Third file example" do
    params = {cart: {
        products: [{product_code: "GR1", quantity: 1}, 
        {product_code: "SR1", quantity: 1},
        {product_code: "CF1", quantity: 3},
      ]
      }
    }
    assert_prices(30.57, 11.23, true, params)
  end

  test "first file example + product without promotion" do
    params = {cart: {
        products: [{product_code: "GR1", quantity: 2},
        {product_code: "CF2", quantity: 1},
      ]
      }
    }
    assert_prices(14.34, products(:one).price, true, params)
  end


  test "Second file example  + product without promotion" do
    params = {cart: {
        products: [{product_code: "GR1", quantity: 1}, 
        {product_code: "SR1", quantity: 3},
        {product_code: "CF2", quantity: 1}
      ]
      }
    }
    assert_prices(27.84, 1.5, true, params)
  end

  test "Third file example + product without promotion" do
    params = {cart: {
        products: [{product_code: "GR1", quantity: 1}, 
        {product_code: "SR1", quantity: 1},
        {product_code: "CF1", quantity: 3},
        {product_code: "CF2", quantity: 1}
      ]
      }
    }
    assert_prices(41.8, 11.23, true, params)
  end

end




