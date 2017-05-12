require "yaml"
require "json"
require "base91"
require "digest"

#fonts = YAML.load(File.read("fonts.yaml"))
#
#notes = []
#
#fonts.each_pair do |name, attributes|
#    attributes = {} if attributes.nil?
#
#    entry = {
#        "__type__" => "Note",
#        "data" => "",
#        "fields" => [
#            name,
#            "<img src=\"#{name.gsub(" ", "_")}.svg\" />",
#            attributes["characteristics"].to_s,
#            attributes["history"].to_s
#        ],
#        "flags" => 0,
#        "guid" => Base91.encode(Digest::SHA256.digest(name))[0..8],
#        "note_model_uuid" => "17cca788-3703-11e7-8da1-448500519c3a",
#        "tags" => []
#    }
#
#    notes << entry
#end

hash = JSON.load(File.read("Fonts/Fonts.json"))
json = JSON.pretty_generate(hash)

json.gsub!("  ", "    ")
json.gsub!(/,$/, ", ")
json.gsub!(/\[\s+\]/, "[]")

#h["notes"] = notes

IO.write("Fonts/Fonts.json", json)
