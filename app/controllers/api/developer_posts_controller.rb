module Api
  class DeveloperPostsController < ApiController
    def index
      developer = Developer.find_by!(email: params[:email])

      latest_posts = Post.joins(:developer)
        .where('developers.email': params[:email])
        .order(created_at: :desc)
        .limit(3)
        .pluck(:title, :slug)
        .map { |t, s| {title: t, slug: s} }

      data = {
        data: {
          developer: developer.slice(:email, :username),
          posts: latest_posts,
        }
      }

      respond_to do |format|
        format.json {render json: data.to_json}
      end
    end
  end
end
