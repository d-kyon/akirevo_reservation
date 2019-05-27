require 'line/bot'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :validate_signature

  def validate_signature
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end
  end

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = "f3a9104c72e90b020a1e435ce5226fa3"
      config.channel_token = "LPSn0lJOnHbSZtxLPpti9iVmCQoEUf+X2+SbOpqpRhbiB9tEbY3Hd5QlBJNo9BYTPWe4Oq8GMfwBajCuXvnrajjgs9TtRJO9pLvlPxLGuLsZ1xAQxwo0Zcz4USHRyqgRuh3l8jjYbo/18owaIBq+igdB04t89/1O/w1cDnyilFU="
    }
  end
end
