class HomesController < ApplicationController
  before_action :authenticate_user!

  def index
    load_data
    redirect_to new_user_session_path unless current_user
  end

  def new_feed
    post = Post.new(post_params)
    load_data if post.save
  end

  def comment
    comment = Comment.new(comment_params)
    load_data if comment.save
  end

  def broadcast_feed_now(html)
    ActionCable.server.broadcast 'reload_new_feeds_channel', html: html
  end

  def posts(limit)
    datas = []
    Post.order(updated_at: :desc).limit(limit).each do |post|
      date_to_day = post&.updated_at.strftime('%d').to_i >= DateTime.now.strftime('%d').to_i
      datas << {
        id: post&.id,
        full_name: post&.user&.full_name,
        user_id: post&.user&.id,
        content: post&.content,
        photo: post&.user&.photo,
        time: "#{post&.updated_at&.strftime("%H:%M")}, #{date_to_day ? 'Today' : post&.updated_at&.strftime('%d/%m/%Y')}"
      }
    end

    return datas
  end

  def comments
    datas = []
    Comment.all.each do |comment|
      date_to_day = comment&.updated_at.strftime('%d').to_i >= DateTime.now.strftime('%d').to_i
      datas << {
        id: comment&.id,
        full_name: comment&.user&.full_name,
        user_id: comment&.user&.id,
        post_id: comment&.post_id,
        content: comment&.content,
        photo: comment&.user&.photo,
        time: "#{comment&.updated_at&.strftime("%H:%M")}, #{date_to_day ? 'Today' : comment&.updated_at&.strftime('%d/%m/%Y')}"
      }
    end

    return datas
  end

  def more_post
    load_data
  end

  def more_comment
    load_data
  end

  def load_data
    @post_max = Post.all.count
    @post_ids = Comment.pluck(:post_id).uniq
    @posts = posts(params[:more_post].present? ? params[:more_post] : 10)
    @comments = comments
    broadcast_feed_now(render_to_string(partial: 'feeds'))
    respond_to do |format|
      format.html {}
      format.js { render json: {status: :success} }
    end
  end

  def post_params
    params.permit(:content, :user_id)
  end

  def comment_params
    params.permit(:content, :user_id, :post_id)
  end
end
