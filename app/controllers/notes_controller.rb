class NotesController < ApplicationController
    def new
    end
    
    def edit
        @note = Note.find(params[:id])
    end
    
    def index
        @notes = Note.all
        @notes = Note.order(created_at: :desc)
    end
    
    def show
        @note = Note.find(params[:id])
    end
    
    def create
        @note = Note.new(note_params)
        
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
            params.require(:note).permit(:title, :content)
        end
end
