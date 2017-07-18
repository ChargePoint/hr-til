require 'rails_helper'

describe Api::DeveloperPostsController, type: :controller do
  let!(:developer) do
    FactoryGirl.create(
      :developer,
      email: 'liz.lemon@hashrocket.com',
      username: 'lizlemon',
    )
  end

  describe '#index' do
    it "shows a Rocketeer's TIL posts" do
      other_developer_post = FactoryGirl.create(:post, created_at: Time.now)

      post1 = FactoryGirl.create(
        :post,
        created_at: Time.now,
        developer: developer,
        slug: '123ABC',
        title: 'How I learned to love JavaScript',
      )

      post3 = FactoryGirl.create(
        :post,
        created_at: Time.now - 2.days,
        developer: developer,
        slug: 'xyz000',
        title: 'JQuery Protips',
      )

      post2 = FactoryGirl.create(
        :post,
        created_at: Time.now - 1.day,
        developer: developer,
        slug: 'def678',
        title: 'Learn Vimium',
      )

      get :index, params: {email: 'liz.lemon@hashrocket.com'}, format: :json

      expected_body = {
        data: {
          developer: {
            email: 'liz.lemon@hashrocket.com',
            username: 'lizlemon',
          },
          posts: [
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
          ]
        }
      }.to_json

      expect(response.body).to eq expected_body
      expect(response.status).to eq 200
    end

    it 'responds with no data when there are no TILs' do
      get :index, params: {email: 'liz.lemon@hashrocket.com'}, format: :json

      expected_body = {
        data: {
          developer: {
            email: 'liz.lemon@hashrocket.com',
            username: 'lizlemon',
          },
          posts: []
        }
      }.to_json

      expect(response.body).to eq expected_body
      expect(response.status).to eq 200
    end

    it 'responds with 404 when the email is not recognized' do
      get :index, params: {email: 'lemon@hashrocket.com'}, format: :json

      expect(response.status).to eq 404
    end
  end
end
