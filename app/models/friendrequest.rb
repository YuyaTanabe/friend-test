class Friendrequest < ApplicationRecord
  belongs_to :user, optional: true
end
