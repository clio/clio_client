module ClioClient
  module Api
    class TaskType < Base

      include ClioClient::Api::Listable
      include ClioClient::Api::Findable
      include ClioClient::Api::Crudable


      private

      def data_klass(*args)
        ClioClient::TaskType
      end

      def end_point_url;     'task_types';  end
      def plural_resource;   'task_types';  end
      def singular_resource; 'task_type';   end

    end
  end
end
