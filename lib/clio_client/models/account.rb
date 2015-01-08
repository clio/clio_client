module ClioClient

  class Account < Resource
    
    set_attributes(id:                {type: :int, readonly: true},
                   created_at:        {type: :datetime, readonly: true},
                   updated_at:        {type: :datetime, readonly: true},
                   maildrop_address:  {type: :string},
                   name:              {type: :string, readonly: true},
                   date_format:       {type: :string, readonly: true},
                   time_format:       {type: :string, readonly: true},
                   document_preview_enabled: {type: :boolean, readonly: true}
                   )
    
    has_association :owner, ClioClient::User

  end

end
