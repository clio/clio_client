module ClioClient

  class Session
    BASE_SCOPE_URL = "https://app.goclio.com"

    include Http
    include Authorization

    attr_accessor :access_token, :client_id, :client_secret, :end_points, :base_scope_url

    def initialize(credentials = {})
      self.access_token = credentials[:access_token]
      self.client_id = credentials[:client_id]
      self.client_secret = credentials[:client_secret]
      self.end_points = {}
      self.base_scope_url = credentials[:base_scope_url] || BASE_SCOPE_URL
    end

    { activities:                 ClioClient::Api::Activity,
      activity_descriptions:      ClioClient::Api::ActivityDescription,
      bills:                      ClioClient::Api::Bill,
      calendar_entries:           ClioClient::Api::CalendarEntry,
      calendars:                  ClioClient::Api::Calendar,
      client_connect_permissions: ClioClient::Api::ClientConnectPermission,
      communications:             ClioClient::Api::Communication,
      contacts:                   ClioClient::Api::Contact,
      custom_field_sets:          ClioClient::Api::CustomFieldSet,
      custom_fields:              ClioClient::Api::CustomField,
      document_versions:          ClioClient::Api::DocumentVersion,
      documents:                  ClioClient::Api::Document,
      document_categories:        ClioClient::Api::DocumentCategory,
      groups:                     ClioClient::Api::Group,
      matters:                    ClioClient::Api::Matter,
      notes:                      ClioClient::Api::Note,
      practice_areas:             ClioClient::Api::PracticeArea,
      relationships:              ClioClient::Api::Relationship,
      tasks:                      ClioClient::Api::Task,
      task_types:                 ClioClient::Api::TaskType,
      timeline_events:            ClioClient::Api::TimelineEvent,
      timer:                      ClioClient::Api::Timer,
      users:                      ClioClient::Api::User
    }.each_pair do |method, klass|
      define_method method do
        end_points[method] ||= klass.new(self)
      end
    end

    def document_versions(document_id)
      end_points[:document_versions] ||= {}
      unless end_points[:document_versions][document_id]
        e = ClioClient::Api::DocumentVersion.new(self)
        e.document_id = document_id
        end_points[:document_versions][document_id] = e
      end
      end_points[:document_versions][document_id]
    end

  end

end
