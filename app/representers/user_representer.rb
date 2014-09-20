class UserRepresenter < Napa::Representer
  property :id, type: String
  property :first_name
  property :last_name
  property :email_address
  property :hashed_screen_name

end
