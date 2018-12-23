class Event < ApplicationRecord
  belongs_to :user
  has_one :place
  
   def self.upcoming(time)
    where(:start_time => time+7200..time+180000).order('start_time ASC')
   end
   
end
