require 'rails_helper'

describe Api::DeveloperPostsController, type: :controller do
  let!(:developer) { FactoryGirl.create :developer, email: 'liz.lemon@hashrocket.com' }

  describe '#index' do
    it "shows a Rocketeer's TIL posts" do
      other_developer_post = FactoryGirl.create(:post, created_at: Time.now)

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

    it 'responds with no data when there are no TILs' do
      get :index, params: {email: 'liz.lemon@hashrocket.com'}, format: :json

      expected_body = {data: []}.to_json

      expect(response.body).to eq expected_body
      expect(response.status).to eq 200
    end

    it 'responds with 404 when the email is not recognized' do
      developer = FactoryGirl.create :developer, email: 'liz.lemon@hashrocket.com'

      get :index, params: {email: 'lemon@hashrocket.com'}, format: :json

      expect(response.status).to eq 404
    end
  end
end
