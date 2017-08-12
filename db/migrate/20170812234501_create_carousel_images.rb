class CreateCarouselImages < ActiveRecord::Migration
  def change
    create_table :carousel_images do |t|
      t.string :carousel
      t.string :image_source_url
      t.string :image_link_url

      t.timestamps null: false
    end
  end
end
