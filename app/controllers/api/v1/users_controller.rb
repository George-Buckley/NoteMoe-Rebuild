class Api::V1::UsersController < Api::V1::ApiController
    before_action :authenticate_with_token!, only: [:update, :destroy]
    respond_to :json
    
    def show
        respond_with User.find(params[:id])
    end
    
    def create
        user = User.new(user_params)
        if user.save
            render json: user, status: 201, location: [:api, user]
        else
            render json: { errors: user.errors }, status: 442
        end
    end
    
    def update
        user = current_user
        
        if user.update(user_params)
            render json: user, status: 200, location: [:api, user]
        else
            render json: { errors: user.errors }, status: 442
        end
    end
    
    def destroy
        current_user.destroy
        head 204
    end
    
    private
        def user_params
            params.require(:user).permit(:email, :password, :password_confirmation)
        end
        
        private
        def restrict_access
            api_key = ApiKey.find_by_access_token(params[:access_token])
            head :unauthorized unless api_key
        end
        
        def generate_authentication_token!
        begin
          self.auth_token = Devise.friendly_token
        end while self.class.exists?(auth_token: auth_token)
        end
end
