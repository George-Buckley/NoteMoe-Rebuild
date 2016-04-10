class NotesController < ApplicationController
    before_action :authenticate_user! 
    before_filter :require_permission, only: [:edit, :show]
    
    def new
        @note = current_user.notes.build
    end
    
    def noaccess
    end
    
    def edit
        @note = Note.find(params[:id])
    end
    
    def index
        @notes = Note.where(user_id: current_user).order(updated_at: :desc).paginate(:page => params[:page], :per_page => 5)
    end
    
    def show
        @note = Note.find(params[:id])
    end
    
    def create
        @note = current_user.notes.build(note_params)
        
        @note.save
        redirect_to @note
    end
    
    def update
        @note = Note.find(params[:id])

        if @note.update(note_params)
            redirect_to @note
        else
            render 'edit'
        end
    end
    
    def destroy
        @note = Note.find(params[:id])
        @note.destroy
        
        redirect_to notes_path
    end
    
    private
        def note_params
            params.require(:note).permit(:title, :content, :user_id)
        end
        
        def require_permission
            if current_user != Note.find(params[:id]).user
                redirect_to noaccess_path
            end
            rescue ActiveRecord::RecordNotFound
                redirect_to nonote_path
        end

end