class ChangePicturesToPictures < ActiveRecord::Migration[5.2]
  def change
    rename_table :pictures, :pictures
  end
end
