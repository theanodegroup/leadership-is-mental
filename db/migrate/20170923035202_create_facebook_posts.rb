class CreateFacebookPosts < ActiveRecord::Migration
  def change
    create_table :facebook_posts do |t|
      t.string :title
      t.string :url
      t.datetime :pub_date
      t.string :posted_by
      t.string :guid
      t.string :image_url

      t.timestamps null: false
    end
  end
end
