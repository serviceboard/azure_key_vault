# frozen_string_literal: true

require "ostruct"

module AzureKV
  # Object class
  class Object < OpenStruct
    def initialize(attribute = {})
      super(attribute)
      @attributes = OpenStruct.new(attribute)
    end

    def method_missing(method, *args, &block)
      attribute = @attributes.send(method, *args, &block)
      attribute.is_a?(Hash) ? Object.new(attribute) : attribute
    end

    def respond_to_missing?(_method, _include_private = false)
      true
    end
  end
end
