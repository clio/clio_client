module ClioClient
  module Api
    class User < Base

      include ClioClient::Api::Listable
      include ClioClient::Api::Findable

      def avatar(id)
        session.get("#{end_point_url}/#{id}/avatar")
      end

      def who_am_i
        resp = session.get("#{end_point_url}/who_am_i")
        [ClioClient::Account.new(resp["account"], session),
         ClioClient::User.new(resp["user"], session)]
      end

      def permissions(id)
        session.get("#{end_point_url}/#{id}/permissions")
      end


      private

      def data_klass(*args)
        ClioClient::User
      end

      def end_point_url;     'users';  end
      def plural_resource;   'users';  end
      def singular_resource; 'user';   end

    end
  end
end
