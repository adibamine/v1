class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save { self.email = email.downcase }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable

   validates :firstname, presence: true, length: {maximum: 50}
   validates :lastname, presence: true, length: {maximum: 50}

   has_many :voitures
   has_many :reservations
   has_many :reviews

   def self.from_omniauth(auth)
   		user = User.where(email: auth.info.email).first
	   	if user
	   		return user
	   	else
	   		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	   		user.provider = auth.provider
	   		user.uid = auth.uid
	   		user.firstname = "#{auth.info.first_name}?type=large"
	   		user.lastname = auth.info.last_name
	   		user.email = auth.info.email
	   		user.image = auth.info.image
	   		user.password = Devise.friendly_token[0,20]
	   		end
	   	end
   end

end
