module ClioClient
  module Api
    module Findable
      
      def find(id, params = {})
        begin
          response = session.get("#{end_point_url}/#{id}", params)
          data_item(response[singular_resource])
        rescue ClioClient::ResourceNotFound, ClioClient::UnknownResponse
          nil
        end
      end

    end
  end
end
