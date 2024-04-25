# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Promotion.create!(name:"2x1",condition: 2, discount_type: "EQUAL", divisor: 1.00)
Promotion.create!(name:"3x2",condition: 3, discount_type: "EQUAL", divisor: 1.00)
Promotion.create!(name:"3x1",condition: 3, discount_type: "EQUAL", divisor: 0.50)

Promotion.create!(name:"10% after 3 units",condition: 3, discount_type: "GREATER", divisor: 10.00)
Promotion.create!(name:"33.33% after 3 units",condition: 3, discount_type: "GREATER", divisor: 3.00)
Promotion.create!(name:"1/5 after 3 units",condition: 3, discount_type: "GREATER", divisor: 5.00)

promotion_2x1 = Promotion.find_by(name: "2x1")
promotion_10percent = Promotion.find_by(name: "10% after 3 units")
promotion_33_percent = Promotion.find_by(name: "33.33% after 3 units")

promotion_3x2 = Promotion.find_by(name: "3x2")
promotion_3x1 = Promotion.find_by(name: "3x1")
promotion_a_fifth = Promotion.find_by(name: "1/5 after 3 units")

Product.create!(code: "GR1", name: "Green Tea", price: 3.11, promotion: promotion_2x1)
Product.create!(code: "SR1", name: "Strawberries", price: 5.00, promotion: promotion_10percent)
Product.create!(code: "CF1", name: "Coffee", price: 11.23, promotion: promotion_33_percent)
Product.create!(code: "CF2", name: "Coffee No Promo", price: 11.23)
Product.create!(code: "CF3", name: "Coffee_3x2", price: 11.23, promotion: promotion_3x2)
Product.create!(code: "CF4", name: "Coffee_3x1", price: 11.23, promotion: promotion_3x1)
Product.create!(code: "CF5", name: "Coffee_fifth", price: 11.23, promotion: promotion_a_fifth)
