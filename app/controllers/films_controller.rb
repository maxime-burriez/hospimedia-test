class FilmsController < ApplicationController
  def index
    client = Swapi::V1::Client.new
    @films = client.films
    @films.each do |film|
      film[:ordered_characters] = client.characters_by_film_ordered_by_mass(film)
    end
  end
end
