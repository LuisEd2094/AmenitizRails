class CartController < ApplicationController

    def index
        @products = Product.all
        @total = 0
    end
    
    def add_to_cart 
        puts params
        begin
            product = Product.get_product(code: params[:products][0][:productCode])
        rescue ActiveRecord::RecordNotFound => e
            render json: { message: "Product not found", error: "Product not found" }, status: :not_found
            return
        end


        has_discount = true
        discount_amount = 3.11
        total = 3.11
        render json: { 
            message: "Item added to cart successfully", 
            success: true, 
            has_discount: has_discount, 
            discount_amount: discount_amount, 
            total: total 
        }

    end
end
