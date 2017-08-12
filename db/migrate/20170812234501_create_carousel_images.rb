class CreateCarouselImages < ActiveRecord::Migration
  def change
    create_table :carousel_images do |t|
      t.string :image_source_url
      t.string :image_link_url
      t.string :carousel

      t.timestamps null: false
    end
  end
end
