require 'sphinx_helper'

RSpec.describe 'Services::SearchService' do
  describe '.call' do
    let(:query) { 'my_query' }

    describe 'search in: scopes' do
      Services::SearchService::SCOPES.each do |search_scope|
        it "calls search in :#{search_scope}" do
          expect(search_scope.singularize.classify.constantize).to receive(:search).with(query)
          Services::SearchService.call(query, search_scope)
        end
      end
    end

    describe 'search in: All' do
      it 'calls search in all with value some' do
        expect(ThinkingSphinx).to receive(:search).with(query)
        Services::SearchService.call(query, 'some')
      end
    end

    describe 'returns result', sphinx: true, js: true do
      let!(:question) { create(:question, title: 'my_query') }
      let!(:answer) { create(:answer, body: 'my_query') }
      let!(:user) { create(:user, email: 'my_query@gmail.com') }
      let!(:second_question) { create(:question, title: 'something_else') }
      let!(:second_answer) { create(:answer, body: 'something_else') }
      let!(:second_user) { create(:user, email: 'something_else@gmail.com') }

      it 'returns only answer' do
        ThinkingSphinx::Test.run do
          expect((Services::SearchService.call(query, 'Answers'))).to match_array [answer]
        end
      end

      it 'returns only objects' do
        ThinkingSphinx::Test.run do
          expect((Services::SearchService.call(query, 'some'))).to match_array [question, answer, user]
        end
      end
    end
  end
end