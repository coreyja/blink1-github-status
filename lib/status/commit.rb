# frozen_string_literal: true

module Status
  class Commit
    STATES = %i[success pending failure error expected].freeze

    def initialize(node)
      @node = node
    end

    STATES.each do |state|
      define_method "#{state}?" do
        send(:state) == state
      end
    end

    def bad?
      failure? || error?
    end

    def good?
      success?
    end

    def waiting?
      pending? || expected?
    end

    def status?
      !node.status.nil?
    end

    def state
      node.status.state.downcase.to_sym
    end

    def color
      if !status?
        Color.purple
      elsif good?
        Color.green
      elsif bad?
        Color.red
      elsif pending?
        Color.yellow
      end
    end

    def pending_since_dim_factor
      pending_context_dim_factors.max
    end

    private

    def pending_context_dim_factors
      pending_contexts.map do |c|
        minutes_ago = (Time.now - Time.parse(c.createdAt)) / 60.0
        minutes_ago * 0.01
      end
    end

    def pending_contexts
      node.status.contexts.select { |s| s.state.to_sym == :PENDING }
    end

    attr_reader :node
  end
end
