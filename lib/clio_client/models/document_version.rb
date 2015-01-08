module ClioClient
  class DocumentVersion < Resource

    set_attributes(id:            {type: :int, readonly: true},
                   document_id:   {type: :int, readonly: true},
                   version:       {type: :int, readonly: true},
                   created_at:    {type: :datetime, readonly: true},
                   updated_at:    {type: :datetime, readonly: true},
                   size:          {type: :int, readonly: true},
                   content_type:  {type: :string, readonly: true},
                   last_modified_at: {type: :datetime},
                   filename:      {type: :string}
                   )

    has_many_association :document_version_notes,           ClioClient::DocumentVersionNote
    
    def download
      api.download(id)
    end


    private
    def api
      session.document_versions(document_id)
    end
      
  end
end
