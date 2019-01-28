require 'gossip'

class ApplicationController < Sinatra::Base
	
	get '/' do
 	 erb :index, locals: {gossips: Gossip.all}
	end

	get '/potins/new/' do
		erb :new_gossip
	end

	post '/gossips/new/' do
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

  post '/gossips/:gossip_id/comment/new/' do 
  	gossip_id = params['gossip_id'].to_i
  	comment_author = params[:comment_author]
  	comment_content = params[:comment_content]
  	Comment.new(gossip_id,comment_author,comment_content).save
  	erb :gossip, locals: {gossip_id: gossip_id} 
  end

  # Redirection de en cas de besoin d'affichage
  get '/gossips/:id/comment/' do
		id =  params['id'].to_i
		redirect '/gossips/1/show/'
	end

end