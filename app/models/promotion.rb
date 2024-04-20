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
end
