class CarouselImage < ActiveRecord::Base
  CAROUSEL_HOME_TOP = "Home - Top".freeze

  CAROUSELS = {
    CAROUSEL_HOME_TOP => "pages/home/carousel/top"
  }.freeze
  CAROUSELS_INVERSE = CAROUSELS.invert.freeze

  POSITION_OFFSET = 2
  POSITION_HALF_OFFSET = POSITION_OFFSET / 2

  default_scope { order(position: :asc, updated_at: :desc) }

  def self.update_positions
    CarouselImage.all.each.with_index(1) do |carousel_image, index|
      carousel_image.update(position: index * POSITION_OFFSET)
    end
  end

  def self.positions
    # Positions are offset to allow for inserting between positions
    num_positions = CarouselImage.all.size + 1
    num_positions.times.map do |i|
      index = "Insert before #{i + 1}"
      index = i == 0 ? "Make First" : index
      index = i == (num_positions - 1) ? "Make Last" : index
      position = (i + 1) * POSITION_OFFSET - POSITION_HALF_OFFSET
      [index, position]
    end
  end

  def position_display
    position / POSITION_OFFSET
  end
end
