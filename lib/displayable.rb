# frozen_string_literal: true

# various display commands, kept here for organization.
module Displayable
  LINE_WIDTH = 80

  def display_clear
    system 'clear'
    puts
  end

  def display(something)
    something.class == Array ? display_array(something) : (puts something.center(LINE_WIDTH))
    puts
  end

  def display_array(something)
    something.each do |line|
      puts line.center(LINE_WIDTH)
    end
  end

  def header
    ['*********************************************',
     '**                                         **',
     '**               Tic-Tac-Toe               **',
     '**                                         **',
     '*********************************************']
  end

  def tell
    { welcome: 'Welcome to tic-tac-toe.',
      invalid: "Sorry, that's not a valid choice. Please try again.",
      tie: 'No winner this time. Both players are losers!' }
  end
end
