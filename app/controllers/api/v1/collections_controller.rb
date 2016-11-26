module Api::V1
  class CollectionsController < BaseController
    def index
      render json: Collection.all
    end
  end
end
