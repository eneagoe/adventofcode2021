#!/usr/bin/env ruby -w

# very ugly, but seems to be correct
gamma, epsilon = "", ""

bits = []
codes = []

File.open(ARGV[0]).readlines.each_with_index do |line, i|
  current = line.chomp.each_char.map(&:to_i)
  codes.append current

  if i.zero?
    bits = current.dup
  else
    bits = bits.zip(current).map { |a, b| a + b }
  end
end

# 1st puzzle
bits.each do |c|
  if codes.size - c > c
    gamma += "1"
    epsilon += "0"
  else
    gamma += "0"
    epsilon += "1"
  end
end

puts gamma.to_i(2) * epsilon.to_i(2)

# 2nd puzzle
g1, g2 = codes.partition { |c| c[0] == 1 }
if codes.size - bits[0] < bits[0]
  oxy_candidates = g1
  co2_candidates = g2
else
  oxy_candidates = g2
  co2_candidates = g1
end

round = 1
while oxy_candidates.size > 1
  ones, zeros = 0, 0
  oxy_candidates.each do |c|
    if c[round] == 1
      ones += 1
    else
      zeros += 1
    end
  end

  if ones >= zeros
    oxy_candidates.filter! { |c| c[round] == 1}
  else
    oxy_candidates.filter! { |c| c[round] == 0}
  end
  round += 1
end

oxy = oxy_candidates[0].reduce { |m, i| m * 2 + i }

round = 1
while co2_candidates.size > 1
  ones, zeros = 0, 0
  co2_candidates.each do |c|
    if c[round] == 1
      ones += 1
    else
      zeros += 1
    end
  end

  if ones >= zeros
    co2_candidates.filter! { |c| c[round] == 0}
  else
    co2_candidates.filter! { |c| c[round] == 1}
  end
  round += 1
end

co2 = co2_candidates[0].reduce { |m, i| m * 2 + i }

puts oxy * co2
