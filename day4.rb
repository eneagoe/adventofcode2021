#!/usr/bin/env ruby -w

require "set"

def validate(board, picked)
  (board + board.transpose).any? { |line| line.all? { |n| picked.include?(n) } }
end

def score(board, picked, last)
  board.flatten.select { |n| !picked.include?(n) }.sum * last
end

numbers = []
boards = []
current = []

File.open(ARGV[0]).readlines.each_with_index do |line, i|
  if i.zero?
    numbers = line.split(/,/).map(&:to_i)
  elsif line.chomp.empty?
    unless current.empty?
      boards << current.dup
      current = []
    end
  else
    current << line.strip.split(/\s+/).map(&:to_i)
  end
end

boards << current unless current.empty?

picked = Set.new
winner = nil

numbers.each do |n|
  picked << n

  if picked.size >= 5
    winner = boards.find { |board| validate(board, picked) }
    puts score(winner, picked, n) if winner

    remaining = boards
    boards = boards.reject { |board| validate(board, picked) }

    if boards.empty?
      puts score(remaining.first, picked, n)
      break
    end
  end
end
