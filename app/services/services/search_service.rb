class Services::SearchService
  SCOPES = %w[Questions Answers Comments Users].freeze

  def self.call(query, scope = nil)
    search_class = determine_search_class(scope)
    escaped_query = escape_query(query)

    search_class.search(escaped_query)
  end

  private

  def self.determine_search_class(scope)
    return ThinkingSphinx unless SCOPES.include?(scope)

    scope.singularize.classify.constantize
  end

  def self.escape_query(query)
    ThinkingSphinx::Query.escape(query)
  end
end