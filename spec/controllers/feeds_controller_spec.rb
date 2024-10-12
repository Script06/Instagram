require 'rails_helper'

RSpec.describe FeedsController, type: :controller do
  describe '#index' do
    subject { get :index }

    context 'when user is authenticated' do
      let(:user) { create(:user) }
      let(:following_user) { create(:user) }
      let(:not_following_user) { create(:user) }

      before do
        sign_in user
      end

      it 'should return 200' do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'should return posts only following_user ' do
        5.times do
          create(:post, user:)
          create(:post, user: following_user)
          create(:post, user: not_following_user)
        end

        user.follow(following_user)

        subject

        assigns(:posts).each do |post|
          expect(post.user_id).to eq(following_user.id)
        end
      end
    end
  end
end
