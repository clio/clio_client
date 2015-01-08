module ClioClient
  module Api
    class DocumentVersion < Base

      attr_accessor :document_id

      include ClioClient::Api::Crudable

      def download(id, params = {})
        session.get("#{end_point_url}/#{id}/download", params)
      end

      private
      def data_item(params)
        params["document_id"] = document_id
        super(params)
      end

      def data_klass(*args)
        ClioClient::DocumentVersion
      end

      def end_point_url;     "documents/#{document_id}/document_versions";  end
      def plural_resource;   'document_versions';  end
      def singular_resource; 'document_version';   end

    end
  end
end
