require 'gossip'

class ApplicationController < Sinatra::Base
	
	get '/' do
 	 erb :index, locals: {gossips: Gossip.all}
	end

	get '/potins/new/' do
		erb :new_gossip
	end

	post '/gossips/new/' do
		puts "Hello, je suis dans le serveur"
		puts "Ceci est mes params :#{params}"
		puts "Author : #{params[:gossip_author]}"
		author = params[:gossip_author]
		puts "Content : #{params[:gossip_content]}"
		content = params[:gossip_content]
		g = Gossip.new(author,content)
		g.save
		puts g.author
		redirect '/'
	end

	get '/gossips/:id/show/' do
		id =  params['id'].to_i
		puts Gossip.all
		erb :gossip, locals: {gossip_id: id}
	end

	get '/gossips/:id/edit' do
		id =  params['id'].to_i
    erb :edit, locals: {gossip_id: id}
  end

  post '/gossips/:id/update/' do 
  	id =  params['id'].to_i
  	author = params[:gossip_author]
  	content = params[:gossip_content]
  	Gossip.update(id, author, content)
    erb :gossip, locals: {gossip_id: id} 
  end


end