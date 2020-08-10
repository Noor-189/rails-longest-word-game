require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = %w(a b c d e t u v y z)
  end

  def score
    @word = params[:word].split('')
    @letters = params[:letters].split(' ')

    response = open("https://wagon-dictionary.herokuapp.com/#{@word.join}")
    json = JSON.parse(response.read)

    @word.each do |letter|
      if @letters.exclude?(letter)
        @sorry = "Sorry, but #{@word.join.upcase} can't be built out of #{@letters.join(', ').upcase}"
      end
    end

    @word.each do |letter|
      if @letters.include?(letter) && json['found'] == false
        @one = "Sorry, but #{@word.join.upcase} does not seem to be a valid English word..."
      end
    end

    @word.each do |letter|
      if @letters.include?(letter) && json['found'] == true
        @both = "Congratulations! #{@word.join.upcase} is a valid English word!"
      end
    end
  end
end
