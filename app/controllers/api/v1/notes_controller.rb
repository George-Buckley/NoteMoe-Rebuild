class Api::V1::NotesController < Api::V1::ApiController
    before_action :authenticate_with_token!, only: [:create, :update]
    
    def index
        notes = params[:note_id].present? ? Note.find(params[:note_id]) : Note.all
        respond_with notes
    end
    
    def show
        respond_with Note.find(params[:id])
    end
    
    def create
    note = current_user.products.build(note_params)
    if product.save
      render json: note, status: 201, location: [:api, note]
    else
      render json: { errors: note.errors }, status: 422
    end
    end

    
    def update
    note = current_user.note.find(params[:id])
    if note.update(note_params)
      render json: note, status: 200, location: [:api, note]
    else
      render json: { errors: note.errors }, status: 422
    end
    end
    
    def destroy
    note = current_user.note.find(params[:id])
    note.destroy
    head 204
    end
    
    private
    def restrict_access
        api_key = ApiKey.find_by_access_token(params[:access_token])
        head :unauthorized unless api_key
    end
    def note_params
      params.require(:note).permit(:title, :content)
    end
end