require "json"
require "base91"
require "digest"

require "./generate"

name = ARGV.join(" ")

generate(name) or exit

entry = {
    "__type__" => "Note",
    "data" => "",
    "fields" => [
        name,
        "<img src=\"#{name.gsub(" ", "_")}.svg\" />",
        "",
        ""
    ],
    "flags" => 0,
    "guid" => Base91.encode(Digest::SHA256.digest(name))[0..8],
    "note_model_uuid" => "17cca788-3703-11e7-8da1-448500519c3a",
    "tags" => []
}

hash = JSON.load(File.read("Fonts/Fonts.json"))

hash["notes"] << entry

json = JSON.pretty_generate(hash)
json.gsub!("  ", "    ")
json.gsub!(/,$/, ", ")
json.gsub!(/\[\s+\]/, "[]")

IO.write("Fonts/Fonts.json", json)
