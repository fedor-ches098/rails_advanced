require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #search' do
    it 'search in scope: All' do
      expect(ThinkingSphinx).to receive(:search).with 'search'
      get :search, params: { search_string: 'search', search_scope: 'All' }
    end

    %w[Question Answer Comment User].each do |scope|
      it "search in scope: #{scope}" do
        expect(scope.constantize).to receive(:search).with 'test'
        get :search, params: { search_string: 'test', search_scope: "#{scope}s" }
      end
    end
  end
end