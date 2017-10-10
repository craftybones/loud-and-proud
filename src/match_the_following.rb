keys="aaaa".."zzzz"

both_halves=keys.inject([[],[]]) do |halves,key|
  halves[0]<<(rand(1000).to_s + key)
  halves[1]<<(key + rand(1000).to_s)
  halves
end

first_half=File.open("first_half","w")
second_half=File.open("second_half","w")

first_half.puts(both_halves[0].shuffle)
second_half.puts(both_halves[1].shuffle)
