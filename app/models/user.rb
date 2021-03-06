class User < ActiveRecord::Base
    attr_accessible :name, :email, :about, :password, :password_confirmation
    attr_accessor :password
    before_save :encrypt_password


    has_many :posts
    has_many :comments
    validates_presence_of :name
    validates_presence_of :email
    validates_email_format_of :email
    validates_uniqueness_of :email
    validates_confirmation_of :password

    # has_secure_password
    validates_presence_of :password, :length => {minimum: 8}, :on => :create

    def self.authenticate(email,password)
    	user = User.find_by_email(email)
    	if user && (user.password_digest == BCrypt::Engine.hash_secret(password, user.password_salt))
    		user
    	else
    		nil
    	end
    end


    def encrypt_password
    	if password.present?
    		self.password_salt = BCrypt::Engine.generate_salt
    		self.password_digest = BCrypt::Engine.hash_secret(password, password_salt)
    	end
    end

end
