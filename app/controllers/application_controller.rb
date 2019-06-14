require 'line/bot'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
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
      config.channel_secret = "42a53b86f92d8b9fcd9182ad191b2446"
      config.channel_token = "/Bbm/CDLP0JloyFSHdfMtdlF008ls2rf/HVvn5NqyhHEOg+HJuwdoPQ71JCQ75xBiDUKWfMQlhVmy+/QJN9KwaCJKs0vNwqB5M52LMcQ4y9MRATuesf9mFijhgPt2eiy+GX8oXueMmKjnm8bfP24IAdB04t89/1O/w1cDnyilFU="
    }
  end
end
