class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.text :image
      t.text :introduce
      t.integer :age
      t.string :sex
      t.string :address

      t.timestamps
    end
  end
end
