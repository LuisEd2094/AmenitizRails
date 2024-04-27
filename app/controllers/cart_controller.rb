class CartController < ApplicationController

    def index
        @products = Product.all
        @total = 0
    end

    def add_to_cart
        cart = {}
        products = params[:cart][:products]
        products.each do | product |
            begin
                new_product= Product.get_product(code: product[:product_code])
                cart[new_product.id] = {product: new_product, quantity: product[:quantity]}
            rescue ActiveRecord::RecordNotFound => e
                render json: { message: "Product not found", error: "Product not found" }, status: :not_found
                return
            rescue => e
                render json: {error: e}
                return
            end
        end


        has_discount = false
        total = BigDecimal(0.00)
        total_discount_amount = BigDecimal(0.00)

        cart.each do | key, value |
            discount_amount = BigDecimal(0.00)
            product = value[:product]
            quantity = value[:quantity]
            promotion = Promotion.get_promotion(id: product.promotion_id)
            if promotion
                discount_amount = promotion.get_discount(quantity, product.price)
                total_discount_amount += discount_amount
            end
            total += (product.price * quantity) - discount_amount
        end
        if total_discount_amount > 0.00
            has_discount = true
        end

        #.to_f.truncate(2).to_s so that it can return just up to the second decimal and we get the correct expected results
        
        render json: { 
            message: "Item added to cart successfully", 
            success: true, 
            has_discount: has_discount, 
            discount_amount: total_discount_amount.to_f.to_s.sub(/(\d+\.\d{2})\d*/, '\1'), 
            total: total.to_f.to_s.sub(/(\d+\.\d{2})\d*/, '\1')
        }

    end
end
