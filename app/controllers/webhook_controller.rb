class WebhookController < ApplicationController
  include WebhookHelper
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
          messages=[]
          if event.message['text']=='申し込む' && user.nil?
            User.create!(line_id:event['source']['userId'])
            seminar_date(Seminar.all,messages,event)
          else
            if user.nil? then
              apply(messages,event)
              
            elsif user.seminar_users.empty? then
              SeminarUser.create!(user_id:user.id,seminar_id:event.message['text'])
              date=Seminar.find(event.message['text']).date
              confirm_date('日程',messages,event,date)
              
            elsif !user.date_is then
              case event.message['text']
              when 'はい'
                user.update!(date_is:true)
                template("それでは次にお名前(漢字)を入力してください",messages,event)
              when '修正する'
                user.seminar_users.destroy_all
                seminar_date(Seminar.all,messages,event)
              else
                template("「はい」か「修正する」でお答えください",messages,event)
              end
              # 漢字名前入力の確認
            elsif user.name.nil? then
              user.update!(name:event.message['text'])
              confirm('お名前',messages,event)

              #ふりがな名前入力
            elsif !user.name_is then
              case event.message['text']
              when 'はい'
                user.update!(name_is:true)
                template("それでは次にお名前のふりがなを入力してください",messages,event)
              when '修正する'
                user.update!(name:nil)
                template("それでは今一度お名前を漢字で入力してください",messages,event)
              else
                template("「はい」か「修正する」でお答えください",messages,event)
              end

              # ふりがな名前入力の確認
            elsif user.name_kana.nil? then
              user.update!(name_kana:event.message['text'])
              confirm('ふりがな',messages,event)

              #メールアドレス入力
            elsif !user.name_kana_is then
              case event.message['text']
              when 'はい'
                user.update!(name_kana_is:true)
                template("それでは次にメールアドレスを入力してください",messages,event)
              when '修正する'
                user.update!(name_kana:nil)
                template("それでは今一度お名前をひらがなで入力してください",messages,event)
              else
                template("「はい」か「修正する」でお答えください",messages,event)
              end

              # メールアドレス入力の確認
            elsif user.email.nil? then
              user.update!(email:event.message['text'])
              confirm('メールアドレス',messages,event)

              #電話番号入力
            elsif !user.email_is then
              case event.message['text']
              when 'はい'
                user.update!(email_is:true)
                template("それでは次に電話番号を入力してください",messages,event)
              when '修正する'
                user.update!(email:nil)
                template("それでは今一度メールアドレスを入力してください",messages,event)
              else
                template("「はい」か「修正する」でお答えください",messages,event)
              end

              # 電話番号入力の確認
            elsif user.phone_number.nil? then
              user.update!(phone_number:event.message['text'])
              confirm('電話番号',messages,event)

              #招待コード入力
            elsif !user.phone_number_is then
              case event.message['text']
              when 'はい'
                user.update!(phone_number_is:true)
                template("それでは次にお持ちでしたら招待コードを入力してください
お持ちでない場合は「なし」と入力してください",messages,event)
              when '修正する'
                user.update!(phone_number:nil)
                template("それでは今一度電話番号を入力してください",messages,event)
              else
                template("「はい」か「修正する」でお答えください",messages,event)
              end

              # 電話番号入力の確認
            elsif user.introduction_code.nil? then
              user.update!(introduction_code:event.message['text'])
              confirm('招待コード',messages,event)

              #意気込み入力
            elsif !user.introduction_code_is then
              case event.message['text']
              when 'はい'
                user.update!(introduction_code_is:true)
                template("それでは最後に意気込みを入力してください",messages,event)
              when '修正する'
                user.update!(introduction_code:nil)
                template("それでは今一度招待コードを入力してください
お持ちでない場合は「なし」と入力してください",messages,event)
              else
                template("「はい」か「修正する」でお答えください",messages,event)
              end

              # 意気込み入力の確認
            elsif user.self.nil? then
              user.update!(self:event.message['text'])
              confirm('意気込み',messages,event)

              #入力完了
            elsif !user.self_is then
              case event.message['text']
              when 'はい'
                user.update!(self_is:true)
                summary(messages,user)
                location(messages)
              when '修正する'
                user.update!(self:nil)
                template("それでは今一度意気込みを入力してください",messages,event)
              else
                template("「はい」か「修正する」でお答えください",messages,event)
              end
            else
              summary(messages,user)
              location(messages)
            end
          end
          # if response then
          #   message = {
          #     type: 'text',
          #     text: response
          #   }
          # messages.push(message)
          # end
          client.reply_message(event['replyToken'], messages)
          
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
