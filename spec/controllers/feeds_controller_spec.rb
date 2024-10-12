require 'rails_helper'
# TODO: Проверить:
# 1) Что возвращаются посты только тех, на кого подписан
# 2) Что возвращается в случае отсуствия подписок?
# НАДО:
RSpec.describe FeedsController, type: :controller do
  describe '#index' do
    subject { get :index }

    context 'when user is authenticated' do
      let(:user) { create(:user) }
      let(:following_user) { create(:user) }
      let(:not_following_user) { create(:user) }

      before { sign_in user }

      it 'should return 200' do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'should return posts only following_user ' do
        debugger
        expect(response).to have_http_status(:success)
      end
    end
  end
end
