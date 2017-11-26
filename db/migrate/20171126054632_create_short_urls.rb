class CreateShortUrls < ActiveRecord::Migration
  def change
    create_table :short_urls do |t|
      t.text :url
      t.string :short_url
      t.text :response_data

      t.timestamps null: false
    end
  end
end
