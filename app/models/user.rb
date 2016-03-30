class User < ActiveRecord::Base

  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end
