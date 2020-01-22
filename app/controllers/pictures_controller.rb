class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy, :correct_user]
  before_action :logged_in?, only:[:new,:create]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @pictures = Picture.all
  end

  def show
    if current_user
      @favorite = current_user.favorites.find_by(picture_id: @picture.id)
    end
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def edit
    @picture.image.cache! unless @picture.image.blank?
  end

  def create
    @picture = current_user.pictures.build(picture_params)

    respond_to do |format|
      if @picture.save
        PictureMailer.picture_mail(@picture).deliver
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    @picture.id = params[:id]
    render :new if @picture.invalid?
  end

  private

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:id, :image, :image_cache, :content)
  end

  def logged_in?
    unless current_user
      flash[:notice] = "ログインしてください"
      redirect_to pictures_path
    end
  end

  def correct_user
    if !current_user
      flash[:notice] = "ログインしてください"
      redirect_to new_session_path
      if @picture.user_id != current_user.id
        flash[:notice] = "あなたのアカウントではアクセス権限がありません"
        redirect_to new_session_path
      end
    end
  end
  
end
