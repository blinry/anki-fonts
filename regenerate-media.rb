require "yaml"
require "json"
require "./generate"

#fonts = YAML.load(File.read("fonts.yaml"))
fonts = []

hash = JSON.load(File.read("Fonts/Fonts.json"))
hash["notes"].each do |note|
    name = note["fields"][0]
    fonts << name
end

puts "Generating specimens for #{fonts.size} fonts."

`rm Fonts/media/*`

fonts.each do |name|
    generate(name)
end
