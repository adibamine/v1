class Review < ActiveRecord::Base
  belongs_to :voiture
  belongs_to :user
end
