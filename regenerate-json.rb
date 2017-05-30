require "yaml"
require "json"
require "./generate"

images = []

hash = JSON.load(File.read("Fonts/Fonts.json"))
hash["notes"].each do |note|
    image = note["fields"][1][10..-5]
    images << image
end

hash["media_files"] = images

json = JSON.pretty_generate(hash)
json.gsub!("  ", "    ")
json.gsub!(/,$/, ", ")
json.gsub!(/\[\s+\]/, "[]")

IO.write("Fonts/Fonts.json", json)
