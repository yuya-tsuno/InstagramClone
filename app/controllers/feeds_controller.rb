class FeedsController < ApplicationController
  before_action :set_feed, only: [:show, :edit, :update, :destroy, :correct_user]
  before_action :logged_in?, only:[:new,:create]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @feeds = Feed.all
  end

  def show
    if current_user
      @favorite = current_user.favorites.find_by(feed_id: @feed.id)
    end
  end

  def new
    if params[:back]
      @feed = Feed.new(feed_params)
    else
      @feed = Feed.new
    end
  end

  def edit
    @feed.image.cache! unless @feed.image.blank?
  end

  def create
    @feed = current_user.feeds.build(feed_params)

    respond_to do |format|
      if @feed.save
        FeedMailer.feed_mail(@feed).deliver
        format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: 'Feed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm
    @feed = current_user.feeds.build(feed_params)
    @feed.id = params[:id]
    render :new if @feed.invalid?
  end

  private

  def set_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:id, :image, :image_cache, :content)
  end

  def logged_in?
    unless current_user
      flash[:notice] = "ログインしてください"
      redirect_to feeds_path
    end
  end

  def correct_user
    if current_user
      if @feed.user_id != current_user.id
        flash[:notice] = "あなたのアカウントではアクセス権限がありません"
      end
    else
      flash[:notice] = "ログインしてください"
    end
    redirect_to feeds_path
  end
  
end
