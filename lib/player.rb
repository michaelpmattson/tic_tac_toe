# frozen_string_literal: true

# Stores player name and token.
class Player
  attr_accessor :name, :token

  def initialize(name)
    @name = name
    @token = token
  end
end
