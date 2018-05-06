#!/usr/bin/env ruby
# frozen_string_literal: true

require 'status'

# exit 1 unless Blink1.enumerate != 0

if ENV.key? 'BLINK1_GITHUB_TOKEN'
  Octokit.configure do |c|
    c.access_token = ENV.fetch('BLINK1_GITHUB_TOKEN')
  end
end

unless ARGV[0]
  p 'Repo is required as the first arg ex: someoneCool/theBestProject'
  exit 1
end

unless ARGV[1]
  p 'Branch is required as the first arg ex: master'
  exit 1
end

# outputs = [Status::Outputs::Blink1, Status::Outputs::Logger]
outputs = [Status::Outputs::Logger]

query = Status::GithubQuery.new(owner: ARGV[0].split('/')[0], name: ARGV[0].split('/')[1], branch: ARGV[1])

colors = Status::ColorGenerator.new(query.commits).colors
colors.each do |c|
  outputs.each { |output| output.new(c).output! }
  sleep 1
end
