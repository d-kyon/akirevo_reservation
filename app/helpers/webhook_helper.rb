module WebhookHelper
    def confirm(content,messages,event)
        contents = {
                  "type": "bubble",
                  "hero": {
                    "type": "image",
                    "url": "https://akitennis-it-lesson.info/assets/lp1_img2.jpg",
                    "size": "full",
                    "aspectRatio": "20:13",
                    "aspectMode": "cover",
                    "action": {
                      "type": "uri",
                      "uri": "https://akirevo.com/"
                    }
                  },
                  "body": {
                    "type": "box",
                    "layout": "vertical",
                    "spacing": "md",
                    "contents": [
                      {
                        "type": "text",
                        "text": "AKIREVO予約サービス",
                        "wrap": true,
                        "weight": "bold",
                        "gravity": "center",
                        "size": "xl"
                      },
                      {
                        "type": "box",
                        "layout": "vertical",
                        "margin": "xs",
                        "contents": [
                          {
                            "type": "spacer"
                          },
                          {
                            "type": "text",
                            "text": content + "は「" + event.message['text'] + "」でよろしいでしょうか？よろしければ「はい」修正したい場合は「修正する」を押してください",
                            "color": "#000000",
                            "wrap": true,
                            "margin": "xs",
                            "size": "md"
                          }
                        ]
                      }
                    ]
                  },
                  "footer": {
                    "type": "box",
                    "layout": "vertical",
                    "spacing": "sm",
                    "contents": [
                      {
                        "type": "button",
                        "style": "link",
                        "height": "sm",
                        "action": {
                          "type": "message",
                          "label": "はい",
                          "text": "はい"
                        }
                      },
                      {
                        "type": "button",
                        "style": "link",
                        "height": "sm",
                        "action": {
                          "type": "message",
                          "label": "修正する",
                          "text": "修正する"
                        }
                      },
                      {
                        "type": "spacer",
                        "size": "sm"
                      }
                    ],
                    "flex": 0
                  }
                }
              message = {
                'type'     => 'flex',
                'altText'  => content+'は「' + event.message['text'] + ' 」でよろしいでしょうか？
よろしければ「はい」
修正したい場合は「修正する」と入力してください',
                'contents' => contents
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
    申し込みをしたい場合は「申し込む」と入力して下さい',
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
  
    def summary(messages,user)
        contents = {
                    "type": "bubble",
                    "hero": {
                      "type": "image",
                      "url": "https://akitennis-it-lesson.info/assets/lp1_img2.jpg",
                      "size": "full",
                      "aspectRatio": "20:13",
                      "aspectMode": "cover",
                      "action": {
                        "type": "uri",
                        "uri": "https://akirevo.com/"
                      }
                    },
                    "body": {
                      "type": "box",
                      "layout": "vertical",
                      "spacing": "md",
                      "contents": [
                        {
                          "type": "text",
                          "text": "AKIREVO予約サービス",
                          "wrap": true,
                          "weight": "bold",
                          "gravity": "center",
                          "size": "xl"
                        },
                        {
                          "type": "box",
                          "layout": "vertical",
                          "margin": "lg",
                          "spacing": "sm",
                          "contents": [
                            {
                              "type": "box",
                              "layout": "baseline",
                              "spacing": "sm",
                              "contents": [
                                {
                                  "type": "text",
                                  "text": "名前",
                                  "color": "#aaaaaa",
                                  "size": "sm",
                                  "flex": 2
                                },
                                {
                                  "type": "text",
                                  "text": user.name,
                                  "wrap": true,
                                  "size": "sm",
                                  "color": "#666666",
                                  "flex": 4
                                }
                              ]
                            },
                            {
                              "type": "box",
                              "layout": "baseline",
                              "spacing": "sm",
                              "contents": [
                                {
                                  "type": "text",
                                  "text": "ふりがな",
                                  "color": "#aaaaaa",
                                  "size": "sm",
                                  "flex": 2
                                },
                                {
                                  "type": "text",
                                  "text": user.name_kana,
                                  "wrap": true,
                                  "color": "#666666",
                                  "size": "sm",
                                  "flex": 4
                                }
                              ]
                            },
                            {
                              "type": "box",
                              "layout": "baseline",
                              "spacing": "sm",
                              "contents": [
                                {
                                  "type": "text",
                                  "text": "e-mail",
                                  "color": "#aaaaaa",
                                  "size": "sm",
                                  "flex": 2
                                },
                                {
                                  "type": "text",
                                  "text": user.email,
                                  "wrap": true,
                                  "color": "#666666",
                                  "size": "sm",
                                  "flex": 4
                                }
                              ]
                            },
                            {
                              "type": "box",
                              "layout": "baseline",
                              "spacing": "sm",
                              "contents": [
                                {
                                  "type": "text",
                                  "text": "電話番号",
                                  "color": "#aaaaaa",
                                  "size": "sm",
                                  "flex": 2
                                },
                                {
                                  "type": "text",
                                  "text": user.phone_number,
                                  "wrap": true,
                                  "color": "#666666",
                                  "size": "sm",
                                  "flex": 4
                                }
                              ]
                            },
                            {
                              "type": "box",
                              "layout": "baseline",
                              "spacing": "sm",
                              "contents": [
                                {
                                  "type": "text",
                                  "text": "招待コード",
                                  "color": "#aaaaaa",
                                  "size": "sm",
                                  "flex": 2
                                },
                                {
                                  "type": "text",
                                  "text": user.introduction_code,
                                  "wrap": true,
                                  "color": "#666666",
                                  "size": "sm",
                                  "flex": 4
                                }
                              ]
                            },
                            {
                              "type": "box",
                              "layout": "baseline",
                              "spacing": "sm",
                              "contents": [
                                {
                                  "type": "text",
                                  "text": "意気込み",
                                  "color": "#aaaaaa",
                                  "size": "sm",
                                  "flex": 2
                                },
                                {
                                  "type": "text",
                                  "text": user.self,
                                  "wrap": true,
                                  "color": "#666666",
                                  "size": "sm",
                                  "flex": 4
                                }
                              ]
                            }
                          ]
                        },
                        {
                          "type": "box",
                          "layout": "vertical",
                          "margin": "xxl",
                          "contents": [
                            {
                              "type": "spacer"
                            },
                            {
                              "type": "text",
                              "text": "以上で申し込みは完了です。下記の場所にてご来場お待ちしております",
                              "color": "#aaaaaa",
                              "wrap": true,
                              "margin": "xxl",
                              "size": "xs"
                            }
                          ]
                        }
                      ]
                    }
                  }
        altText="以上で申し込みは完了です。ご連絡をお待ちください。
お名前：#{user.name}
お名前(ふりがな)：#{user.name_kana}
メールアドレス：#{user.email}
電話番号：#{user.phone_number}
招待コード：#{user.introduction_code}
意気込み：#{user.self}"
        message= {
                  "type": "flex",
                  "altText": altText,
                  "contents": contents
                  }
        messages.push(message)
    end
    
    def template(content,messages,event)
        contents =  {
                          "type": "bubble",
                          "hero": {
                            "type": "image",
                            "url": "https://akitennis-it-lesson.info/assets/lp1_img2.jpg",
                            "size": "full",
                            "aspectRatio": "20:13",
                            "aspectMode": "cover",
                            "action": {
                              "type": "uri",
                              "uri": "https://akirevo.com/"
                            }
                          },
                          "body": {
                            "type": "box",
                            "layout": "vertical",
                            "spacing": "md",
                            "contents": [
                              {
                                "type": "text",
                                "text": "AKIREVO予約サービス",
                                "wrap": true,
                                "weight": "bold",
                                "gravity": "center",
                                "size": "xl"
                              },
                              {
                                "type": "box",
                                "layout": "vertical",
                                "margin": "xs",
                                "contents": [
                                  {
                                    "type": "spacer"
                                  },
                                  {
                                    "type": "text",
                                    "text": content,
                                    "color": "#000000",
                                    "wrap": true,
                                    "margin": "xs",
                                    "size": "md"
                                  }
                                ]
                              }
                            ]
                        }
                    }
        message= {
                  "type": "flex",
                  "altText": content,
                  "contents": contents
                  }
        messages.push(message)
    end
end
