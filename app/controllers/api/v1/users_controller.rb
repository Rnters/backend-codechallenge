class Api::V1::UsersController < ActionController::Base
  #before_action :restrict_access
  before_action :get_user, only: [:show]

  #http_basic_authenticate_with name: 'rnters', password: 'sign€d'
  # GET /users
  def index
    get_users
    #poderia ser utilizado serializer
    render json: @users, only: [:first_name, :last_name, :admin]

  end

  # GET /users/1
  def show
    render json: @user, only: [:first_name, :last_name, :admin]
  end

  # POST /users
  def create
    @user = User.new(user_params)


    if @user.save
      render json: @user, only: [:first_name, :last_name, :admin], status: :created
    else
      # status 422
      render json: @user.errors, status: :bad_request
    end
  end

  # PATCH/PUT /users/1
  #def update
   # if @user.update(user_params)
    #  render json: @user, only: [:first_name, :last_name]
    #else
     # render json: @user.errors, status: :bad_request
   # end
  #end

  # DELETE /users/1
  #def destroy
   # @user.destroy

    #head :no_content
  #end

  private
    def get_user
      @user = User.find_by(id: params[:id])

      if @user.nil?
        render json: {message: I18n.t('user_not_found')}, status: :not_found
      end
    end


   # def restrict_access
    #  token = request.headers['Autorization-token']
     # if !ApiKey.exists?(access_token: token)
      #  render json: {message: I18n.t('invalid_token')}, status: :unauthorized
     # end
   # end

    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(*User.attr_accessible)
    end

    def get_users

      @users = User.all
    end
end
