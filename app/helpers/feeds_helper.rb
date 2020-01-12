module FeedsHelper

  def choose_new_or_edit
    if action_name == 'new' || action_name == 'confirm' || action_name == 'create'
      confirm_feeds_path
    elsif action_name == 'edit'
      confirm_feed_path
    end
  end

  def confirm_new_or_edit
    unless @feed.id? # params[:commit] == 'Create Feed'
      feeds_path
    else
      feed_path
    end
  end

  def confirm_form_method
    @feed.id ? 'patch' : 'post' # 作成時はpost, 編集時はpatchを指定
  end

end
