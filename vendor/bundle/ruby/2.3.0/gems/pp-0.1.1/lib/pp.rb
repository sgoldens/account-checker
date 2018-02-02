require 'pp/room'

# Provides a method to listen and respond to messages in a Campfire room.
module Pp
  # Listen and respond to messages in a Campfire room.
  #
  # @example Interact in the room https://xxx.campfirenow.com/room/123 as the user with token 'abcd'
  #
  #   require 'pp'
  #   Pp.run 'xxx', 123, 'abcd'
  #
  # @param [String] subdomain The campfirenow.com subdomain that hosts the room
  # @param [Integer] room_id The ID of the Campfire room
  # @param [String] token The token of the Campfire user to interact with
  #
  # @see https://github.com/37signals/campfire-api for Campfire API documentation
  def self.run(options = {})
    Room.new(options).listen do |room, request|
      room.respond_with request.response if request.relevant?
    end
  end
end