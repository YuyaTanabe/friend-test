class Location < ApplicationRecord
  belongs_to :user, optional: true

  attachment :location_image

  # geocoder が address から経度・緯度を取得
  geocoded_by :address
  after_validation :geocode
end
