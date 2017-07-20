module Api
  class DeveloperPostsController < ApiController
    def index
      developer = Developer.find_by!(username: params[:username])

      latest_posts = Post.joins(:developer)
        .where('developers.username': params[:username])
        .order(created_at: :desc)
        .limit(3)
        .pluck(:title, :slug)
        .map { |t, s| {title: t, slug: s} }

      data = {
        data: {
          posts: latest_posts,
        }
      }

      respond_to do |format|
        format.json {render json: data.to_json}
      end
    end
  end
end
