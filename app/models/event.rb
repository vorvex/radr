class Event < ApplicationRecord
  belongs_to :user
  belongs_to :place
  
   def self.upcoming(time)
    where(:start_time => time+7200..time+180000).order('start_time ASC')
   end
   
end
