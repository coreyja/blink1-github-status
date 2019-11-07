#!/usr/bin/env ruby
# frozen_string_literal: true

require 'status'

if ENV.key? 'BLINK1_GITHUB_TOKEN'
  Octokit.configure do |c|
    c.access_token = ENV.fetch('BLINK1_GITHUB_TOKEN')
  end
end

unless ARGV[0]
  puts 'Repo is required as the first arg ex: someoneCool/theBestProject'
  exit 1
end

unless ARGV[1]
  puts 'Branch is required as the first arg ex: master'
  exit 1
end

outputs = [Status::Outputs::Blink1.new, Status::Outputs::Logger.new, Status::Outputs::Lifx.new]

availible_outputs = outputs.select(&:available?)
exit 0 if availible_outputs.empty?

query = Status::GithubQuery.new(owner: ARGV[0].split('/')[0], name: ARGV[0].split('/')[1], branch: ARGV[1])

colors = Status::ColorGenerator.new(query.commits).colors
colors.each do |c|
  availible_outputs.each { |output| output.output!(c) }
  sleep 1
end
