require 'multi_json'

module GutData
  module Mixin
    module ToJson
      def to_json(pretty = false)
        MultiJson.dump(json, pretty)
      end
    end
  end
end
