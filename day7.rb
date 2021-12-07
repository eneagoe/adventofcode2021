#!/usr/bin/env ruby -w

def computeCost(positions, x)
  positions.sum { |v| (v - x).abs }
end

def computeCostExp(positions, x)
  positions.sum { |v| n = (v - x).abs; n * (n + 1) / 2 }
end

positions = File.open(ARGV[0]).readline.split(/,/).map(&:to_i)

# 1st puzzle
positions.sort

left, right = positions.min, positions.max

while right - left > 2
  mid1 = left + (right - left) / 3
  mid2 = right - (right - left) / 3

  cost1 = computeCost(positions, mid1)
  cost2 = computeCost(positions, mid2)

  if cost1 < cost2
    right = mid2
  else
    left = mid1
  end
end

puts computeCost(positions, (left + right) / 2)
# 2nd puzzle
left, right = positions.min, positions.max

while right - left > 2
  mid1 = left + (right - left) / 3
  mid2 = right - (right - left) / 3

  cost1 = computeCostExp(positions, mid1)
  cost2 = computeCostExp(positions, mid2)

  if cost1 < cost2
    right = mid2
  else
    left = mid1
  end
end

puts computeCostExp(positions, (left + right) / 2)
