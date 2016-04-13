class Api::V1::NotesController < Api::V1::ApiController
    before_filter :restrict_access
    respond_to :json
    
    def index
        respond_with Note.all
    end
    
    def show
        respond_with Note.find(params[:id])
    end
    
    def create
        respond_with Note.create(params[:note])
    end
    
    def update
        respond_with Note.update(params[:id], params[:note])
    end
    
    def destroy
        respond_with Note.destroy(params[:id])
    end
    
    private
    def restrict_access
        api_key = ApiKey.find_by_access_token(params[:access_token])
        head :unauthorized unless api_key
    end
end