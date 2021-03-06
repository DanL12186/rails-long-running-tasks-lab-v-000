class SongsController < ApplicationController

  require 'csv'

  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def upload
    # binding.pry
    CSV.foreach(params[:file].path, headers: true) do |song|
      # binding.pry
      Song.create(title: song[0], artist_id: Artist.find_or_create_by(name: song[1]))
    end
    redirect_to songs_path
  end

#   def upload
#   CSV.foreach(params[:leads].path, headers: true) do |lead|
#     Customer.create(email: lead[0], first_name: lead[1], last_name: lead[2])
#   end
#   redirect_to customers_path
# end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end
