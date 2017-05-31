def generate(name)
    parts = name.split(" ")
    if ["Light", "Bold"].include? parts.last
        weight = parts.pop.downcase
        weight = "100" if weight == "light"
    else
        weight = "normal"
    end
    font = parts.join(" ")

    print name+"..."
    STDOUT.flush

    svg = IO.read("specimen-template.svg")
    svg.gsub!("Arial", font).gsub!("normal", weight)
    IO.write("/tmp/specimen.svg", svg)

    results = `fc-match '#{font}'`
    if results =~ /DejaVuSans/
        puts "not found on system."
    else
        `inkscape --export-text-to-path --export-plain-svg /tmp/specimen-plain.svg /tmp/specimen.svg`
        `svgo /tmp/specimen-plain.svg`
        `cp /tmp/specimen-plain.svg Fonts/media/#{name.gsub(" ", "_")}.svg`
        puts
    end
end

if __FILE__==$0
    generate(ARGV.join(" "))
end
