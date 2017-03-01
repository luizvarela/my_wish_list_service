module Api::V1
  class CollectionsController < BaseController
    def index
      collections = Collection.all
      data = ::V1::CollectionsSerializer.represent(collections.to_a)
      render json: api_response(data: data)
    end

    def show
      collection = Collection.find(params[:id])
      data = ::V1::CollectionSerializer.represent(collection)
      render json: api_response(data: data)
    end

    def create
      collection = Collection.new collection_params

      if collection.save!
        render json: api_response(data: collection),
          location: v1_collection_url(collection, format: :json),
          status: :created
      end
    end

    private

    def collection_params
      permitted = params.permit(:name,
        items: [:id, :name, :price])
      if permitted[:items].present?
        permitted[:items_attributes] = permitted.delete :items
      end
      permitted
    end
  end
end
