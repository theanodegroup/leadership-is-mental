class CreateLeadershipArticles < ActiveRecord::Migration
  def change
    create_table :leadership_articles do |t|
      t.string :title
      t.text :content
      t.datetime :pub_date
      t.text :summary
      t.string :source
      t.string :guid
      t.text :image_url

      t.timestamps null: false
    end
  end
end
