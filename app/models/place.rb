class Place < ApplicationRecord
  belongs_to :user
  has_many :event
end
