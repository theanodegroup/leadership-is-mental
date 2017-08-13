class CarouselImage < ActiveRecord::Base
  CAROUSEL_HOME_TOP = "Home - Top".freeze

  CAROUSELS = {
    CAROUSEL_HOME_TOP => "pages/home/carousel/top"
  }.freeze
  CAROUSELS_INVERSE = CAROUSELS.invert.freeze
end
