class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
<<<<<<< HEAD
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
=======
         :recoverable, :rememberable, :trackable, :validatable
  #has_many :hoges により子モデル（hoge）が複数紐づくアソシエーションを定義できる
>>>>>>> 86c0d6a2f261c85091f30297c2b2b23311003ea3
  has_many :blogs
end
