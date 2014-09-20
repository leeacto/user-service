class UsersApi < Grape::API

  helpers do
    def load_user!
      Napa::Logger.logger.info "Retrieving User: #{params[:id]}"
      user =  User.where(id: params[:id]).first
      if user
        return user
      else
        Napa::Logger.logger.info "User #{params[:id]} Not Found"
        error! "User Not Found", 404
      end
    end
  end

  desc 'Get a list of users'
  params do
    optional :ids, type: Array, desc: 'Array of user ids'
  end

  get do
    users = params[:ids] ? User.where(id: params[:ids]) : User.all
    represent users, with: UserRepresenter
  end

  desc 'Create a user'
  params do
    requires :first_name, type: String, desc: "The User's first name"
    requires :last_name, type: String, desc: "The User's last name"
    requires :email_address, type: String, desc: "The User's email address"
  end

  post do
    Napa::Logger.logger.info "Creating User: #{permitted_params}"
    user = User.create(permitted_params)
    if user.errors.blank?
      Napa::Logger.logger.info "User (id: #{user.id}) successfully created"
      represent user, with: UserRepresenter
    else
      Napa::Logger.logger.info "User not created - error: #{user.errors.full_messages.to_sentence}"
      error! user.errors.full_messages.to_sentence, 400
    end
  end

  params do
    requires :id, desc: 'ID of the user'
  end
  route_param :id do
    desc 'Get a user'
    get do
      user = load_user!
      represent user, with: UserRepresenter
    end

    desc 'Update a user'
    params do
      optional :first_name, type: String, desc: "The User's first name"
      optional :last_name, type: String, desc: "The User's last name"
      optional :email_address, type: String, desc: "The User's email address"
    end
    put do
      # fetch user record and update attributes.  exceptions caught in app.rb
      user = load_user!
      user.update_attributes!(permitted_params)
      represent user, with: UserRepresenter
    end
  end
end
