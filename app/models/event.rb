class Event < ApplicationRecord
  belongs_to :user
  belongs_to :place
  
   def self.upcoming
    where(:start_time => Time.now+7200..Time.now+1800000).order('start_time ASC')
   end
   
end
