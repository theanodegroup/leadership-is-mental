# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Phraser

if Rails.env.development?
  5.times do |index|
    CarouselImage.create({
      carousel: CarouselImage::CAROUSELS_INVERSE[CarouselImage::CAROUSEL_HOME_TOP],
      image_source_url: "https://via.placeholder.com/700x400&text=Carousel+image+#{index}",
      image_link_url: "https://leadership-is-mental-myklclason.c9users.io/?i=#{index}",
      position: index * 10 + 10
    })
  end
end