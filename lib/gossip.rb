require 'csv'
require 'chilkat'

class Gossip

	attr_accessor :author, :content


	def initialize(author_name, gossip_content)
		@author = author_name
		@content = gossip_content
	end

	def save
		CSV.open("./db/gossip.csv", "ab") do |csv|
    	csv << [@author, @content]
 		end
	end

	def self.update(id, author, content)
		csv = Chilkat::CkCsv.new()
		success = csv.LoadFile("./db/gossip.csv")
		if (success != true)
		    print csv.lastErrorText() + "\n";
		    exit
		end

		# MAJ de l'auteur
		success = csv.SetCell(id-1,0,author)
		# MAJ du contenu
		success = csv.SetCell(id-1,1,content)

		success = csv.SaveFile("./db/gossip.csv")
		if (success != true)
		    print csv.lastErrorText() + "\n";
		end


	end

	def self.all
		all_gossips = []
			CSV.read("./db/gossip.csv").each do |csv_line|
				all_gossips << Gossip.new(csv_line[0], csv_line[1])
			end
		return all_gossips
	end

	def self.find(id)
		all_gossips = Gossip.all
		return all_gossips[id-1]
	end

end

# Gossip.update(1,"Autheur MAJ 1","ContentMAJ 1")

# Gossip.new("Fred", "Gossip 1").save
# Gossip.new("Marc", "Gossip 2").save

# puts Gossip.all