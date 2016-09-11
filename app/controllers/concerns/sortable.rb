module Sortable
  extend ActiveSupport::Concern

  module ClassMethods
    def sort_by_attribute(attribute)
      self.all.sort_by(&attribute.to_sym).reverse
    end
  end
end
