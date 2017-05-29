def generate(name)
    font = name

    print name+"... "

    results = `fc-list | grep '#{font}'`
    if results == ""
        puts "not found on system."
    else

        svg = IO.read("specimen-template.svg")
        svg.gsub!("Arial", font)#.gsub!("normal", weight)
        IO.write("/tmp/specimen.svg", svg)

        `inkscape --export-text-to-path --export-plain-svg /tmp/specimen-plain.svg /tmp/specimen.svg`
        `svgo /tmp/specimen-plain.svg`
        `cp /tmp/specimen-plain.svg Fonts/media/#{name.gsub(" ", "_")}.svg`

        puts "done."
    end
end
