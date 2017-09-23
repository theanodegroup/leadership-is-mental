class CreateFacebookPosts < ActiveRecord::Migration
  def change
    create_table :facebook_posts do |t|
      t.string :title
      t.string :facebook_url
      t.string :guid
      t.string :image_url

      t.timestamps null: false
    end
  end
end
