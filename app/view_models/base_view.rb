# frozen_string_literal: true

class BaseView
  def initialize(object, view_context = nil)
    @object = object
    @view_context = view_context
  end

  class << self
    def collection(objects, view_context)
      objects.map { |object| new(object, view_context) }
    end
  end

  protected

  attr_reader :object, :view_context

  def method_missing(method_name, *arguments, &block)
    object.send(method_name, *arguments, &block)
  end

  # :reek:BooleanParameter
  def respond_to_missing?(method_name, include_private = false)
    object.send(:respond_to_missing?, method_name, include_private)
  end
end
