class WebhookController < ApplicationController
	require "open-uri"
	require "net/https"
	skip_before_action :verify_authenticity_token
	force_ssl 

	def receive
		chat=params['message']['chat']['id']
		words=params['message']['text'].split
		case words[0]
		when "/start"
			start(chat)
		when "/help"
			help(chat)
		when "/ads"
			ads(chat, words[1])
		when "/ad"
			ad(chat, words[1])
		else
			send_message(chat, "Oops, seems like i can't understand you")
		end
		render :json => {:ok => true, :result => true}
	end

	private

	def send_message(chat, text)
		url=URI.parse("https://api.telegram.org/bot371175469:AAFZjsjbupLsvM4o7I0VPAADRd5cM_6-Y70/sendMessage")
		req=Net::HTTP::Post.new(url.path)
		req.form_data={chat_id: chat, text: text}
		con=Net::HTTP.new(url.host, url.port)
		con.use_ssl=true
		res=con.start{|http| http.request(req)}
	end

	def is_integer?(str)
		str.match(/\A\d+\z/)==nil ? false : true
	end

	def ads(chat, number)
		if is_integer?(number)
			ads=Ad.last(number.to_i)
			ads.each do |ad|
				send_message(chat, "Ad: #{ad.id}\n Title: #{ad.title}")
			end
		else 
			send_message(chat, "Wrong usage of command /ads")
		end
	end

	def ad(chat, number)
		if is_integer?(number)
			if ad=Ad.find_by(id: number.to_i)
				send_message(chat, "Ad: #{ad.id}\nTitle: #{ad.title}\nCategory: #{ad.category}\nDeadline: #{ad.deadline}\nExpected hours: #{ad.expected_hours}\nApplicant: #{ad.applicant_user}\nDescription: #{ad.description}")
			else
				send_message(chat, "We didn't find that ad, sorry")
			end
		else 
			send_message(chat, "Wrong usage of command /ad")
		end
	end

	def start(chat)
		send_message(chat, "Hi! Welcome to TimeSharing official bot! This bot offers some of our main site's features, try them!")
	end

	def help(chat)
		send_message(chat, "You can use /ads <n> to receive a list of latest n ads' titles added to our main site, or you can use /ad <id> to see <id> specific ad")
	end
end
