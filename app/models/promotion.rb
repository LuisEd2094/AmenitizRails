class Promotion < ApplicationRecord
    has_many :products
    def self.get_promotion(attributes = {})

        if attributes.present? && attributes.size < 2
            id = attributes[:id]
            Promotion.find_by(id: id)
        else
            raise ArgumentError, "Id attribute is required"
        end
    end

    def get_discount(units, price)
        discount = BigDecimal(0.0)
        discount_per_unit = BigDecimal(price / self.divisor)
        if self.discount_type == "EQUAL"
            if units >= self.condition
                discount +=  discount_per_unit * (units / self.condition)
            end
        elsif self.discount_type == "GREATER"
            if units >= self.condition
                discount += units * discount_per_unit
            end
        end
        discount
    end
end
