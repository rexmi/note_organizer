require "#{Rails.root}/lib/assets/note_search"

class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  include Notes_Mod

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # search Note.all then render
  def search
    results = create_serach_result(Note.all)
    notes_array = process_notes_array(results)

    if results.empty?
      render :body => ['nothing in here']
    else
      render file: 'app/views/notes/search.html.erb', layout: false, locals: {:notes => notes_array}
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:title, :body, :tags)
    end


    # not done yet
    def rank_tags(tags, key_tag)
      p 'hi'
    end

    def create_serach_result(input)
      keys, tags = Notes_Mod.create_key_tag(params[:search])
      result_hash = Notes_Mod.give_score(input, keys)

    # return result in descending order
      result_hash.sort_by { |k, v| v }.reverse
    end

    # generate array of qualifited Notes
    def process_notes_array(array_of_id)
      notes = []
      array_of_id.each do |d|
        notes << Note.find(d[0].to_i)
      end
      notes
    end
end
