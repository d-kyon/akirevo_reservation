class WebhookController < ApplicationController
  protect_from_forgery :except => [:callback]
  
  def confirm(content,messages,event)
    template= {
                'type'    => 'confirm',
                'text'    => content+'は「' + event.message['text'] + ' 」でよろしいでしょうか？
よろしければ「はい」
修正したい場合は「修正する」を押してください',
                'actions' => [
                                {'type'=>'message', 'label'=>'はい', 'text'=>'はい'},
                                {'type'=>'message', 'label'=>'修正する', 'text'=>'修正する'}
                              ]
              }
              message = {
                'type'     => 'template',
                 'altText'  => content+'は「' + event.message['text'] + ' 」でよろしいでしょうか？
よろしければ「はい」
修正したい場合は「修正する」と入力してください',
                 'template' => template
              }
              messages.push(message)
  end
  
  def apply(messages,event)
    template= {
                'type'    => 'buttons',
                'thumbnailImageUrl' => 'https://akitennis-it-lesson.info/assets/lp1_img2.jpg',
                'title'   => 'AKIREVO予約サービス' ,
                'text'    => 'こんにちは、AKIREVO予約サービスです！申し込みをしたい場合は「申し込む」をタップしてください',
                'actions' => [
                                {'type'=>'message', 'label'=>'申し込む', 'text'=>'申し込む'}
                              ]
              }
              message = {
                'type'     => 'template',
                 'altText'  => 'こんにちは、AKIREVO予約サービスです！
申し込みをしたい場合は「申し込み」と入力して下さい',
                 'template' => template
              }
              messages.push(message)
  end
  
  def location(messages)
    message= {
                'type'      => 'location',
                'title'     => 'アクセス',
                'address'   => 'セントラルパークタワー　ラ・トゥール新宿',
                'latitude'  => 35.692179,
                'longitude' => 139.688554
                }
                messages.push(message)
  end
  
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
            response='申し込みありがとうございます。
まずはお名前を漢字で入力してください。'
          else
            if user.nil? then
              apply(messages,event)

              # 漢字名前入力の確認
            elsif user.name.nil? then
              user.update!(name:event.message['text'])
              confirm('お名前',messages,event)

              #ふりがな名前入力
            elsif !user.name_is then
              case event.message['text']
              when 'はい'
                user.update!(name_is:true)
                response="それでは次にお名前のふりがなを入力してください"
              when '修正する'
                user.update!(name:nil)
                response="それでは今一度お名前を漢字で入力してください"
              else
                response="「はい」か「修正する」でお答えください"
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
                response="それでは次にメールアドレスを入力してください"
              when '修正する'
                user.update!(name_kana:nil)
                response="それでは今一度お名前をひらがなで入力してください"
              else
                response="「はい」か「修正する」でお答えください"
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
                response="それでは次に電話番号を入力してください"
              when '修正する'
                user.update!(email:nil)
                response="それでは今一度メールアドレスを入力してください"
              else
                response="「はい」か「修正する」でお答えください"
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
                response="それでは次にお持ちでしたら招待コードを入力してください
お持ちでない場合は「なし」と入力してください"
              when '修正する'
                user.update!(phone_number:nil)
                response="それでは今一度電話番号を入力してください"
              else
                response="「はい」か「修正する」でお答えください"
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
                response="それでは最後に意気込みを入力してください"
              when '修正する'
                user.update!(introduction_code:nil)
                response="それでは今一度招待コードを入力してください
お持ちでない場合は「なし」と入力してください"
              else
                response="「はい」か「修正する」でお答えください"
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
                location(messages)
              
                response="以上で申し込みは完了です。上記会場にてご来場お待ちしております。
==申し込み内容==
お名前：#{user.name}
お名前(ふりがな)：#{user.name_kana}
メールアドレス：#{user.email}
電話番号：#{user.phone_number}
招待コード：#{user.introduction_code}
意気込み：#{user.self}"
              when '修正する'
                user.update!(self:nil)
                response="それでは今一度意気込みを入力してください"
              else
                response="「はい」か「修正する」でお答えください"
              end
            else
              location(messages)
              response="申し込みは完了しております。上記会場にてご来場お待ちしております。
==申し込み内容==
お名前：#{user.name}
お名前(ふりがな)：#{user.name_kana}
メールアドレス：#{user.email}
電話番号：#{user.phone_number}
招待コード：#{user.introduction_code}
意気込み：#{user.self}"
            end
          end
          if response then
            message = {
              type: 'text',
              text: response
            }
          messages.push(message)
          end
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
