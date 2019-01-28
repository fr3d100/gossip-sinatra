require 'csv'

class Comment

	attr_accessor :gossip_id, :author, :content

	def initialize(comment_gossip_id,comment_author, comment_content)
		@gossip_id =comment_gossip_id
		@author = comment_author
		@content =comment_content
	end

	def save
		CSV.open("./db/comments.csv", "ab") do |csv|
    	csv << [@gossip_id, @author, @content]
 		end
	end


	def self.all 
		all_comments = []
		CSV.read('./db/comments.csv').each do |csv_line|
			all_comments << Comment.new(csv_line[0],csv_line[1],csv_line[2])
		end
		return all_comments
	end

	def self.get_gossip_comments(id_gossip)
		# Création d'un tableau qui cotiendra tous les commenttaires relatifs à ce gossip
		gossip_comments = []
		all_comments = Comment.all
		all_comments.each do |comment|
		# Si le commentaire appartient au gossip voulu, on le met dans notre tableau
			if comment.gossip_id.to_i == id_gossip.to_i
				gossip_comments << comment
			end
		end
		return gossip_comments
	end

end

# c = Comment.new(1,"user_anonyme","je le savais !")
# c.save

# puts Comment.all[0].author

puts Comment.get_gossip_comments(1)