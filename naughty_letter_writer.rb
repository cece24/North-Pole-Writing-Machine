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
  # random toy to receive, ensure it's not a kaleidoscope
  is_kaleidoscope = true

  while is_kaleidoscope
    random_number = rand(1..5)
    gift_toy = toys[random_number]
    if gift_toy != "Kaleidoscope"
      is_kaleidoscope = false
    end
  end

  # remove gift toy from toys array to list in letter
  toys.delete(gift_toy)

  # infraction
  kid_infraction_array = kid.split("|")
  infraction = kid_infraction_array[1].strip

  filename = "letters/naughty/" + name + ".txt"
  letter_text = ERB.new(naughty_letter, nil, "-").result(binding)

  File.write(filename, letter_text)
  # puts "Letter has been written for #{ name }!"

  # puts "Current line has this info: #{ name }, #{ gender }, #{ behaviour }, #{ toys }, with infraction: #{ infraction }"
end
