module ApplicationHelper
  def link_cache_key(link)
    link_type = link.gist? ? 'gist' : 'simple'

    "links/#{link.id}/#{link_type}-#{link.updated_at.to_f}"
  end

  def answer_cache_key(answer)
    answer_type = answer.best? ? 'best' : 'simple'

    "answers/#{answer.id}/#{answer_type}-#{answer.updated_at.to_f}"
  end
end
