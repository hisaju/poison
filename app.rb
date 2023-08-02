# frozen_string_literal: true

require 'sinatra/base'
require 'slim'
require 'dotenv/load'
require 'discordrb'

class App < Sinatra::Application
  get '/' do
    slim :index
  end

  post '/poison' do
    btn = 'out'
    btn = 'out' if params[:out]
    btn = 'kusa' if params[:kusa]
    btn = 'normal' if params[:normal]
    btn = 'high' if params[:high]
    btn = 'hightone' if params[:hightone]
    btn = 'hayakuchi' if params[:hayakuchi]
    btn = 'nagame' if params[:nagame]

    client = Discordrb::Webhooks::Client.new(url: ENV.fetch('WEBHOOK_URL'))
    client.execute do |builder|
      builder.content = '!poison'
      builder.add_embed do |embed|
        embed.title = params[:channel]
        embed.url = "https://hisaju-kaerenai.s3.ap-northeast-1.amazonaws.com/poison/#{btn}.mp3"
      end
    end
    redirect '/'
  end
end
