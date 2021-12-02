#!/usr/bin/env ruby -w

distance, depth = 0, 0
aim, aimed_depth = 0, 0

File.open(ARGV[0]).readlines.each do |line|
  direction, change = line.split(/\s+/)
  change = change.to_i

  case direction
  when "forward"
    distance += change
    aimed_depth += aim * change
  when "up"
    depth -= change
    aim -= change
  when "down"
    depth += change
    aim += change
  end
end

# 1st puzzle
puts distance * depth

# 2nd puzzle
puts distance * aimed_depth
