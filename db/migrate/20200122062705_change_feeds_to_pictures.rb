class ChangeFeedsToPictures < ActiveRecord::Migration[5.2]
  def change
    rename_table :feeds, :pictures
  end
end
