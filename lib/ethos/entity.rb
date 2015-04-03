require 'ethos/schema'
require 'ethos/attributes'
require 'ethos/collection'

module Ethos
  module Entity
    module ClassMethods
      def schema
        @_schema ||= Ethos::Schema.new
      end

      def attribute(key, type, default: nil, &extension)
        schema.define key, type, default: default, extensions: [extension].compact

        reader = :"#{key}"
        writer = :"#{key}="

        define_method reader do
          attributes[key]
        end

        define_method writer do |value|
          attributes[key] = value
        end
      end

      def collection(key, type)
        attribute key, Ethos::Collection, default: []

        schema.attributes[key][:extensions].push Proc.new { self.type = type }
      end
    end

    def self.prepended(base)
      base.extend ClassMethods
    end

    def initialize(values = {})
      self.attributes = values

      super()
    end

    def attributes=(values)
      @_attributes = Ethos::Attributes.new self.class.schema, values: values
    end

    def attributes
      @_attributes
    end

    def ==(other)
      return false unless other.is_a? self.class

      self.attributes == other.attributes
    end
  end
end
