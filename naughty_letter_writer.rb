require "erb"

kids_data = File.read("data/kids-data.txt")
naughty_letter = File.read("templates/naughty_letter_template.txt.erb")

kids_data.each_line do |kid|
  naughty_kid_array = kid.split

  name = naughty_kid_array[0]
  gender = naughty_kid_array[1]
  behaviour = naughty_kid_array[2]
  toys = naughty_kid_array[3..8]

  next unless behaviour == "naughty"
  # infraction
  kid_infraction_array = kid.split("|")
  infraction = kid_infraction_array[1]

  filename = "letters/naughty/" + name + ".txt"
  letter_text = ERB.new(naughty_letter, nil, "-").result(binding)

  File.write(filename, letter_text)
  puts "Letter has been written for #{ name }!"

  puts "Current line has this info: #{ name }, #{ gender }, #{ behaviour }, #{ toys }, with infraction: #{ infraction }"
end
