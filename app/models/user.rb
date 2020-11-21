class User < ApplicationRecord
    has_secure_password
    
    has_many :comments, dependent: :destroy

    validates_presence_of :email
    validates_uniqueness_of :email
    validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i}
end
