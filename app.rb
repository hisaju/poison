# frozen_string_literal: true

require 'sinatra/base'
require 'slim'
require 'dotenv/load'
require 'discordrb'

class App < Sinatra::Application
  use Rack::Auth::Basic, "ユーザ名とパスワードを入力してください" do |username, password|
    username == ENV.fetch('BASIC_AUTH_USER') && password == ENV.fetch('BASIC_AUTH_PASSWORD')
  end
  get '/' do
    slim :index
  end

  post '/poison' do
    btn = 'out'
    %i/out kusa normal high hightone hayakuchi nagame kick gomente iine tsukareta amane aizen/.each do |key|
      btn = key.to_s if params[key]
    end

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
