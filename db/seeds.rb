# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Promotion.create!(name:"2x1",condition: 2, discount_type: "EQUAL", discount_percent: 100.00)
promotion = Promotion.find_by(name: "2x1")

Product.create!(code: "GR1", name: "Green Tea", price: 3.11, promotion: promotion)
Product.create!(code: "SR1", name: "Strawberries", price: 5.00, promotion: promotion)
Product.create!(code: "CF1", name: "Coffee", price: 11.23, promotion: promotion)
