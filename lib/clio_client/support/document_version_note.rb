module ClioClient
  class DocumentVersionNote < Resource

    set_attributes(user_id:                 {type: :int, readonly: true},
                   subject:                 {type: :string},
                   detail:                  {type: :string}, 
                   created_at:              {type: :datetime, readonly: true},
                   updated_at:              {type: :datetime, readonly: true},
                   )

  end
end
