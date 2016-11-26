module Api::V1
  class BaseController < ApplicationController
    rescue_from 'ActiveRecord::RecordInvalid', with: :return_422
    rescue_from 'ActiveRecord::RecordNotFound', with: :return_404

    def api_response(options = {})
      options.reverse_merge!(data: {}, errors: {}, meta: {})
      options
    end

    def return_422(exception)
      errors = ::V1::Errors::ValidationsSerializer.new(exception.record).serialize
      render json: api_response(errors: errors), status: 422
    end

    def return_404
      render json: api_response(errors: { code: 'not_found' }), status: :not_found
    end
  end
end
