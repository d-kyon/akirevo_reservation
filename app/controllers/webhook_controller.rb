class WebhookController < ApplicationController
  protect_from_forgery :except => [:callback]
  def callback
    body = request.body.read
    events = client.parse_events_from(body)

    events.each { |event|
      case event
      when Line::Bot::Event::Follow

      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          if User.find_by(line_id:event['source']['userId']) then
            user=User.find_by(line_id:event['source']['userId'])
          end
          if event.message['text']=='申し込み' && user.nil?
            User.create!(line_id:event['source']['userId'])
            response='申し込みありがとうございます。まずはお名前を漢字で入力してください。'
          else
            if user.nil? then
              response="申し込みをしたい場合は「申し込み」と入力して下さい"

              # 漢字名前入力
            elsif user.name.nil? then
              user.update!(name:event.message['text'])
              response="名前は「#{event.message['text']}様」でよろしいでしょうか？
よろしければ「はい」修正したい場合は「いいえ」と入力して下さい"
            elsif !user.name_is then
              case event.message['text']
              when 'はい'
                user.update!(name_is:true)
                response="それでは次にお名前のふりがなを入力してください"
              when 'いいえ'
                user.update!(name:nil)
                response="それでは今一度お名前を漢字で入力してください"
              else
                response="「はい」か「いいえ」でお答えください"
              end

              # ふりがな名前入力
            elsif user.name_kana.nil? then
              user.update!(name_kana:event.message['text'])
              response="「#{event.message['text']}様」でよろしいでしょうか？
よろしければ「はい」修正したい場合は「いいえ」と入力して下さい"
            elsif !user.name_kana_is then
              case event.message['text']
              when 'はい'
                user.update!(name_kana_is:true)
                response="それでは次にメールアドレスを入力してください"
              when 'いいえ'
                user.update!(name_kana:nil)
                response="それでは今一度お名前をひらがなで入力してください"
              else
                response="「はい」か「いいえ」でお答えください"
              end

              # メールアドレス入力
            elsif user.email.nil? then
              user.update!(email:event.message['text'])
              response="メールアドレスは「#{event.message['text']}」でよろしいでしょうか？
よろしければ「はい」修正したい場合は「いいえ」と入力して下さい"
            elsif !user.email_is then
              case event.message['text']
              when 'はい'
                user.update!(email_is:true)
                response="それでは次に電話番号を入力してください"
              when 'いいえ'
                user.update!(email:nil)
                response="それでは今一度メールアドレスを入力してください"
              else
                response="「はい」か「いいえ」でお答えください"
              end

              # 電話番号入力
            elsif user.phone_number.nil? then
              user.update!(phone_number:event.message['text'])
              response="電話番号は「#{event.message['text']}」でよろしいでしょうか？
よろしければ「はい」修正したい場合は「いいえ」と入力して下さい"
            elsif !user.phone_number_is then
              case event.message['text']
              when 'はい'
                user.update!(phone_number_is:true)
                response="それでは次にお持ちでしたら招待コードを入力してください
お持ちでない場合は「なし」と入力してください"
              when 'いいえ'
                user.update!(phone_number:nil)
                response="それでは今一度電話番号を入力してください"
              else
                response="「はい」か「いいえ」でお答えください"
              end

              # 招待コード入力
            elsif user.introduction_code.nil? then
              user.update!(introduction_code:event.message['text'])
              response="招待番号は「#{event.message['text']}」でよろしいでしょうか？
よろしければ「はい」修正したい場合は「いいえ」と入力して下さい"
            elsif !user.introduction_code_is then
              case event.message['text']
              when 'はい'
                user.update!(introduction_code_is:true)
                response="それでは次に意気込みを入力してください"
              when 'いいえ'
                user.update!(introduction_code:nil)
                response="それでは今一度招待コードを入力してください
お持ちでない場合は「なし」と入力してください"
              else
                response="「はい」か「いいえ」でお答えください"
              end

              # 意気込み入力
            elsif user.self.nil? then
              user.update!(self:event.message['text'])
              response="「#{event.message['text']}」でよろしいでしょうか？
よろしければ「はい」修正したい場合は「いいえ」と入力して下さい"
            elsif !user.self_is then
              case event.message['text']
              when 'はい'
                user.update!(self_is:true)
                response="以上で申し込みは完了です。ご連絡をお待ちください。
お名前：#{user.name}
お名前(ふりがな)：#{user.name_kana}
メールアドレス：#{user.email}
電話番号：#{user.phone_number}
招待コード：#{user.introduction_code}
意気込み：#{user.self}"
              when 'いいえ'
                user.update!(self:nil)
                response="それでは今一度意気込みを入力してください"
              else
                response="「はい」か「いいえ」でお答えください"
              end
            end
          end
          message = {
            type: 'text',
            text: response
          }
          client.reply_message(event['replyToken'], message)
        else
          message = {
            type: 'text',
            text: '回答は文章でお願いします'
          }
          client.reply_message(event['replyToken'], message)
        end
      end
    }
    "OK"
  end
end
