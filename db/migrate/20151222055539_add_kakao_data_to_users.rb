class AddKakaoDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :photo_url, :string
  end
end
