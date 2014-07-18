class User < ActiveRecord::Base
	belongs_to :customer
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	  :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :first_name, :last_name, :username, :customer_id, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :created_at, :updated_at
end
