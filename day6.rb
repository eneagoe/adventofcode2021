#!/usr/bin/env ruby -w

ages = File.open(ARGV[0]).readline.split(/,/).map(&:to_i)

# 1st puzzle
80.times do
  ages.map! do |v|
    if v.zero?
      [6, 8]
    else
      v - 1
    end
  end.flatten!
end
puts ages.size

# 2nd puzzle
# brute-force will not work anymore
ages = File.open(ARGV[0]).readline.split(/,/).map(&:to_i).tally
ages.default = 0

256.times do
  ages.transform_keys! { |v| v - 1 }
  ages[8] = ages[-1]
  ages[6] += ages[-1]
  ages[-1] = nil
end

puts ages.values.compact.sum
