class MessagesController < ApplicationController
  include ApplicationHelper
  require 'nexmo'

  Client = Nexmo::Client.new(
    api_key: '0f7a5bd0',
    api_secret: 'Ldx9DqkOoUMhg24o'
  )

  def index
    @messages = Message.recent_by_number.by_date
  end

  def show
    @messages = Message.for_number(params[:id])
    @new_message = Message.new(number: params[:id])
  end

  def create
    puts clean_params
    puts'MESSAGE'
    message = Message.new(clean_params)
    message.inbound = false
    if message.save
      Client.sms.send(
        from: '12015373203',
        to: clean_params[:number],
        text: clean_params[:text]
      )
      redirect_to "/messages/#{message.number}"
    end
  end

  private

  def clean_params
    params.require(:message).permit(:number, :text)
  end
end
