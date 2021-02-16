# frozen_string_literal: true

module Collectionable
  def wrap_in_view_models(view_model_klass, collection)
    Kaminari.paginate_array(
      view_model_klass.collection(collection, view_context),
      total_count: collection.total_count
    ).page(params[:page])
  end
end
