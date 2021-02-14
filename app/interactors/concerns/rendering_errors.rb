# frozen_string_literal: true

module RenderingErrors
  # :reek:UtilityFunction
  def render_api_error(object)
    object.errors.full_messages.join(' | ')
  end
end
