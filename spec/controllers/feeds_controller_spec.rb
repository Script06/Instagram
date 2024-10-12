require 'rails_helper'
# TODO: Проверить:
# 1) Что возвращаются посты только тех, на кого подписан
# 2) Что возвращается в случае отсуствия подписок?
# НАДО:
RSpec.describe FeedsController, type: :controller do
  describe '#index' do
    subject { get :index }

    context 'when user is authenticated' do
      let(:current_user) { create(:user) }
      let(:following_user) { create(:user) }
      let(:not_following_user) { create(:user) }

      before do
        sign_in current_user
      end

      it 'should return 200' do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'should return posts only following_user ' do
        5.times do
          create(:post, user: current_user)
          create(:post, user: following_user)
          create(:post, user: not_following_user)
        end

        current_user.follow(following_user)

        subject

        assigns(:posts).each do |post|
          expect(post.user_id).to eq(following_user.id)
        end
      end
    end
  end
end
