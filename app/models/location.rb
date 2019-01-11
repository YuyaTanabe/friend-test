class Location < ApplicationRecord
  belongs_to :user, optional: true

  attachment :location_image

end
