class FavoritesController < ApplicationController

  def index
    @favorites = Favorite.all
  end

  def create
    favorite = current_user.favorites.create(feed_id: params[:feed_id])
    redirect_to feeds_url, notice: "#{favorite.feed.user.name}さんのブログをお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to feeds_url, notice: "#{favorite.feed.user.name}さんのブログをお気に入り解除しました"
  end

end
