class User < ActiveRecord::Base
  has_many :books
  has_many :book_histories
  before_save { self.email = email.downcase } 
  validates :name, 
            :presence => true
  validates :email,
            :presence => true,
            :uniqueness => {:message => "Email już istnieje"},
            :email_format => {:message => "Email jest nie prawidłowy"}
  validates :password,
            :length => {:minimum => 8 },
            :presence => {:message => "Wpisz hasło"},
            :allow_nil => true
  has_secure_password
end
