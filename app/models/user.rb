class User < ApplicationRecord
  before_destroy :least_one
  before_validation { email.downcase! }
  has_many :tasks,dependent: :destroy
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :email, uniqueness: true
  has_secure_password #パスワードのハッシュ化とpassword,password_confirmationが使えるようになる
  validates :password, presence: true, length: { minimum: 6 }
  
  private
   def least_one
     unless User.where(admin: 'true').count >= 2 || self.admin == false
       throw(:abort) 
     end
   end

  # def least_one
  #   if User.where(admin: 'true').count <= 1 || self.admin == true
  #     throw :abort
  #   end
  # end

end
