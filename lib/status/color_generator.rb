# frozen_string_literal: true

module Status
  class ColorGenerator
    def initialize(commits)
      @commits = commits
    end

    def colors
      Array color_or_colors
    end

    private

    attr_reader :commits

    def color_or_colors
      if commits_with_status.empty?
        Status::Color.purple
      elsif most_recent_commit.waiting?
        [Status::Color.yellow, most_recent_non_pending.color.dim_by(dim_factor)]
      else
        most_recent_commit.color
      end
    end

    def dim_factor
      [most_recent_commit.pending_since_dim_factor || 0.5, 0.85].min
    end

    def most_recent_commit
      @most_recent_commit ||= commits_with_status.first
    end

    def most_recent_non_pending
      @most_recent_non_pending ||= commits_with_status.find { |x| !x.waiting? }
    end

    def commits_with_status
      @commits_with_status ||= commits.select(&:status?)
    end
  end
end
