class User < ApplicationRecord
  before_destroy :destroy_way
  before_validation { email.downcase! }
  has_many :tasks,dependent: :destroy
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :email, uniqueness: true
  has_secure_password #パスワードのハッシュ化とpassword,password_confirmationが使えるようになる
  validates :password, presence: true, length: { minimum: 6 }
  
  private
  def destroy_way
    unless User.where(admin: 'true').count >= 2 || self.admin == false
      throw(:abort) 
    end
  end

end
