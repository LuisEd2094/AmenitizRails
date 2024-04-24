class Promotion < ApplicationRecord
    has_many :products
    def self.get_promotion(attributes = {})
        if attributes.present? && attributes.key?(:id)
            raise ArgumentError, "Additional attributes are not allowed" if attributes.keys.length > 1
            id = attributes[:id]
            product = Promotion.find_by!(id: id)
            product
        else
            raise ArgumentError, "Id attribute is required"
        end
    end

    def get_discount(units, price)
        discount = BigDecimal(0.0)
        if self.discount_type == "EQUAL"
            if units >= self.condition
                discount_per_unit = price / self.divisor

                discount +=  discount_per_unit * (units / self.condition)
            end
        elsif self.discount_type == "GREATER"
            if units >= self.condition
                discount_per_unit = price / self.divisor
                discount += units * discount_per_unit
            end
        end
        discount
    end
end
