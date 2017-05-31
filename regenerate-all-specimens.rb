require "yaml"
require "json"
require "./generate-specimen"

#fonts = YAML.load(File.read("fonts.yaml"))
fonts = []

hash = JSON.load(File.read("Fonts/Fonts.json"))
hash["notes"].each do |note|
    name = note["fields"][1][10..-9].gsub("_", " ")
    fonts << name
end

puts "Generating specimens for #{fonts.size} fonts."

`rm Fonts/media/*`

fonts.each do |name|
    generate(name)
end
