module Api::V1
  class CollectionsController < BaseController
    def index
      render json: api_response(data: Collection.all)
    end

    def show
      collection = Collection.find(params[:id])
      render json: api_response(data: collection)
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
      params.permit(:name)
    end
  end
end
