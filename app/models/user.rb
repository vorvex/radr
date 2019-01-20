class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :events
  has_many :places
  
  def trial?
    count = (DateTime.parse(self.created_at.to_s)...Date.today).count
    if count < 14
      return true
    else
      return false
    end
  end
  
end
