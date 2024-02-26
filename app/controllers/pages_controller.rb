require 'open-uri'
require 'json'
require 'net/http'

class PagesController < ApplicationController
  def new
    @letters = []
    @letters << ('A'..'Z').to_a.sample until @letters.length == 10
    session[:list] = @letters
  end

  def score
    answer = params[:answer].upcase
    uri = URI("https://wagon-dictionary.herokuapp.com/#{answer}")
    page_info = Net::HTTP.get(uri)
    @score = JSON.parse(page_info)

    if @score['found'] == true
      @score = "Congratulations! #{answer} is a valid English Word!"
    else
      @score = "Sorry but #{answer} does not seem to be a valid Englsih word..."
    end

    answer.chars.each do |letter|
      @score = "Sorry but #{answer} can't be built out of #{session[:list].join(',')}" unless session[:list].include?(letter)
    end
  end
end
