require 'rails_helper'

describe Api::DeveloperPostsController, type: :controller do
  let(:developer) { FactoryGirl.create :developer, email: 'liz.lemon@hashrocket.com' }

  describe '#index' do
    it "shows a Rocketeer's TIL posts" do
      post1 = FactoryGirl.create(:post, developer: developer, title: 'How I learned to love JavaScript', slug: '123ABC', created_at: Time.now)
      post3 = FactoryGirl.create(:post, developer: developer, title: 'JQuery Protips', slug: 'xyz000', created_at: Time.now - 2.days)
      post2 = FactoryGirl.create(:post, developer: developer, title: 'Learn Vimium', slug: 'def678', created_at: Time.now - 1.day)

      get :index, params: {email: 'liz.lemon@hashrocket.com'}, format: :json

      expected_body = {data: [
        {
          title: 'How I learned to love JavaScript',
          slug: '123ABC'
        },
        {
          title: 'Learn Vimium',
          slug: 'def678'
        },
        {
          title: 'JQuery Protips',
          slug: 'xyz000'
        }
      ]}.to_json

      expect(response.body).to eq expected_body
      expect(response.status).to eq 200
    end
  end
end
