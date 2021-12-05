#!/usr/bin/env ruby -w

class Integer
  def sign
    if self.zero?
      return 0
    elsif self < 0
      return -1
    else
      return 1
    end
  end
end

n, m = 0, 0

lines = File.open(ARGV[0]).readlines.map do |line|
  start, stop = line.split(/\s+->\s+/)
  x1, y1 = start.split(/,/).map(&:to_i)
  x2, y2 = stop.split(/,/).map(&:to_i)
  n, m = [n, x1, x2].max, [m, y1, y2].max
  [x1, y1, x2, y2]
end

n += 1
m += 1

grid = Array.new(m) { Array.new(n) { 0 } }

# 1st puzzle
lines.each do |x1, y1, x2, y2|
  if x1 == x2
    y1, y2 = [y1, y2].min, [y1, y2].max
    (y1..y2).each do |y|
      grid[y][x1] += 1
    end
  elsif y1 == y2
    x1, x2 = [x1, x2].min, [x1, x2].max
    (x1..x2).each do |x|
      grid[y1][x] += 1
    end
  end
end

puts grid.flatten.count { |x| x >= 2 }

# 2nd puzzle
grid = Array.new(m) { Array.new(n) { 0 } }

lines.each do |x1, y1, x2, y2|
  l1 = (x2 - x1).abs
  l2 = (y2 - y1).abs
  s1 = (x2 - x1).sign
  s2 = (y2 - y1).sign

  (0..[l1, l2].max).each do |i|
    x, y = x1 + s1 * i, y1 + s2 * i
    grid[y][x] += 1
  end
end

puts grid.flatten.count { |x| x >= 2 }
