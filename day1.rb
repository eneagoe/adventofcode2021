#!/usr/bin/env ruby -w

a = []

File.open(ARGV[0]).each do |m|
  a << m.to_i
end

first_solution = a.each_cons(2).sum { |x, y| x < y ? 1 : 0 }

puts first_solution

second_solution = a.each_cons(3).map(&:sum).each_cons(2).sum { |x, y| x < y ? 1 : 0 }

puts second_solution
