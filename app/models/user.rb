class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :email_address, :hashed_screen_name
  validates_uniqueness_of :email_address, :case_sensitive => false
  validates_format_of     :email_address, :with => /\A([\p{Alnum}~*_\+\-\.']+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  before_validation :update_hashed_screen_name

  protected

  def update_hashed_screen_name
    self.hashed_screen_name = SipHash.digest(self.email_address.downcase) if self.email_address.present?
  end
end
