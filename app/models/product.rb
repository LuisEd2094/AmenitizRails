class Product < ApplicationRecord
  belongs_to :promotion, optional: true
  
  def self.get_product(attributes = {})
    if attributes.present? && attributes.key?(:code)
      raise ArgumentError, "Additional attributes are not allowed" if attributes.keys.length > 1
      code = attributes[:code]
      product = Product.find_by!(code: code)
      product
    else
      raise ArgumentError, "Code attribute is required"
    end
  end
end
