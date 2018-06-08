class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_favorites
  # has many :user_histories
  has_many :user_searches
  has_many :questions
  has_many :answers
  has_many :reviews
end
