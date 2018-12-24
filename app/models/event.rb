class Event < ApplicationRecord
  belongs_to :user
  belongs_to :place
  
   def self.upcoming
    where('start_time > ?', Time.now).order('start_time ASC')
   end
  
   def self.old
    where('start_time < ?', Time.now)
   end
   
end
