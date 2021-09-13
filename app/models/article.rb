class Article < ApplicationRecord
  include Elasticsearch::Model

  def self.search_author(keyword)
    if keyword.present?
      query = {
        "query": {
          "match": {
            "author": keyword
          }
        }
      }

      self.__elasticsearch__.search(query)
    else
      self.none
    end
  end
end
