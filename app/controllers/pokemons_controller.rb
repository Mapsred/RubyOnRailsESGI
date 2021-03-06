# frozen_string_literal: true

# PokemonsController
class PokemonsController < ApplicationController
  before_action :fetch_pokemon, only: %i[show edit update destroy]

  def fetch_pokemon
    @pokemon = Pokemon.find(params[:id])
  end

  def index
    @pokemons = Pokemon.includes(:type)
  end

  def show
    # @pokemon fetched from :fetch_pokemon
  end

  def new
    @pokemon = Pokemon.new
  end

  def create
    @pokemon = Pokemon.new pokemon_parameters
    if @pokemon.save
      redirect_to @pokemon
    else
      render 'new'
    end
  end

  def edit
    # @pokemon fetched from :fetch_pokemon
  end

  def update
    puts params
    if @pokemon.update(pokemon_parameters)
      flash[:success] = 'Pokemon #' + params[:id] + ' updated !'

      redirect_to @pokemon
    else
      render 'edit'
    end
  end

  def destroy
    @pokemon.destroy

    redirect_to pokemons_url
  end

  private

  def pokemon_parameters
    params.require(:pokemon).permit(:name, :level, :number, :type_id, :health_points, :health_points, move_ids: [])
  end
end