class Article < ApplicationRecord
  include Elasticsearch::Model

  settings do
    mapping dynamic: 'false' do # 動的にマッピングを生成しない
      indexes :title, analyzer: 'kuromoji', type: 'text'
      indexes :author, analyzer: 'kuromoji', type: 'text'
    end
  end


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
