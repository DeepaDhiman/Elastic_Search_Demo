class Product < ApplicationRecord
	include Elasticsearch::Model
	include Elasticsearch::Model::Callbacks


    def self.search(query='',query_type='')
      if query_type == "match_all"
        main_query = { match_all: {} }
      else
        main_query =  {
            multi_match: {
            query: query,
            fields: ["name"]
          }
        }
      end
      __elasticsearch__.search(
        {
          query: main_query
        }
      )
    end
end

Product.import force: true
