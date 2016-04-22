module Admin4rails
  module Utility
    def self.compare(x, y)
      return x == y if x.class == y.class
      return x == y.to_sym if x.is_a?(Symbol) && y.is_a?(String)
      return x.to_sym == y if x.is_a?(String) && y.is_a?(Symbol)
      raise ArgumentError, 'Wrong arguments type'
    end

    def self.module_exists?(module_name)
      Admin4rails.const_get module_name.to_s
      true
    rescue NameError
      false
    end
  end
end
