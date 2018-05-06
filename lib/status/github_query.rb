# frozen_string_literal: true

module Status
  class GithubQuery
    def initialize(owner:, name:, branch:)
      @owner = owner
      @name = name
      @branch = branch
    end

    def commits
      history = response.data.repository.ref.target.history
      _page_info = history[:page_info]
      nodes = history[:nodes]
      nodes.map { |node| Status::Commit.new(node) }
    end

    private

    attr_reader :owner, :name, :branch

    def response
      Octokit.post 'graphql', { query: graphql_query, variables: graphql_variables }.to_json
    end

    def graphql_query
      File.read(File.dirname(__FILE__) + '/../../queries/commit_statuses.graphql')
    end

    def graphql_variables
      {
        pageSize: 10,
        owner: owner,
        name: name,
        branch: branch
      }.to_json
    end
  end
end
