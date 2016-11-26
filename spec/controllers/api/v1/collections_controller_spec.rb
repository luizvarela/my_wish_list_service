require 'rails_helper'

RSpec.describe Api::V1::CollectionsController, type: :controller do
  describe '#index' do
    before { create :collection, name: 'My Wish List' }

    it "returns all collections" do
      get :index
      expect(response).to have_http_status(200)
      expect(response_data.map { |collection| collection['name'] }).to eq(["My Wish List"])
    end
  end

  describe '#create' do
    describe 'with valid attributes' do
      let(:collection_params) { { name: 'My Collection' } }

      before { post :create, params: collection_params }

      it 'shows that collection' do
        created_collection = response_data
        expect(created_collection['name']).to eq collection_params[:name]
      end

      it 'returns a success status' do
        expect(response).to have_http_status(201)
      end

      it 'sets the location header' do
        created_collection = response_data
        expect(response.headers["Location"]).to match %r{/v1/collections/#{created_collection['id']}.json}
      end
    end

    describe 'with invalid attributes' do
      it 'returns validation errors' do
        post :create, params: {}
        
        expect(response_errors.first['resource']).to eq('collection')
        expect(response_errors.first['field']).to eq('name')
        expect(response_errors.first['code']).to eq('cant_be_blank')
      end
    end
  end

  def response_data
    parsed_response['data']
  end

  def response_errors
    parsed_response['errors']
  end

  def parsed_response
    JSON.parse(response.body)
  end
end
