class SubscribesController < ApplicationController
  layout false

  def create
    email = params[:email]
    s = Subscribe.new(email: email)
    if s.save
      render json: { status: 1, message: "subscribe success" }
    else
      messages = ''
      s.errors.messages.each do |m|
        messages << m[1][0]
      end
      render json: { status: -1, message: messages }
    end
  end
end
