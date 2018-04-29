#!/usr/bin/env ruby
# frozen_string_literal: true

require 'octokit'
require 'blink1'

require_relative '../lib/color'
require_relative '../lib/commit'

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

query = File.read(File.dirname(__FILE__) + '/../queries/commit_statuses.graphql')
variables = {
  pageSize: 10,
  owner: ARGV[0].split('/')[0],
  name: ARGV[0].split('/')[1],
  branch: ARGV[1]
}.to_json

response = Octokit.post 'graphql', { query: query, variables: variables }.to_json

history = response.data.repository.ref.target.history
page_info = history[:page_info]
nodes = history[:nodes]
commits = nodes.map { |node| Commit.new(node) }

commits_with_status = commits.select(&:status?)
if commits_with_status.empty?
  Color.purple.set_blink!
else
  most_recent_commit = commits_with_status.first
  if most_recent_commit.waiting?
    Color.yellow.set_blink!
    sleep 1
    most_recent_non_pending = commits.reject(&:pending?).first
    dim_factor = most_recent_commit.pending_since_dim_factor || 0.5
    most_recent_non_pending.color.dim_by(dim_factor).set_blink!
  else
    most_recent_commit.color.set_blink!
  end
end
