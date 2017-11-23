class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :title_phrase_id
      t.integer :summary_phrase_id
      t.integer :source_phrase_id
      t.string :image_url_phrase_id

      t.timestamps null: false
    end
  end
end
