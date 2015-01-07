module ClioClient

  class User < Resource

    set_attributes(id:                {type: :int, readonly: true},
                   created_at:        {type: :datetime, readonly: true},
                   updated_at:        {type: :datetime, readonly: true},
                   subscription_plan: {type: :string, readonly: true},
                   time_zone:         {type: :string, readonly: true},
                   first_name:        {type: :string, readonly: true},
                   last_name:         {type: :string, readonly: true},
                   email:             {type: :string, readonly: true},
                   enabled:           {type: :boolean, readonly: true},
                   name:              {type: :string, readonly: true},
                   clio_connect:      {type: :boolean, readonly: true},
                   has_avatar:        {type: :boolean, readonly: true},
                   co_counsel:        {type: :boolean, readonly: true}
                   )

    has_association(:contact,            ClioClient::Contact,
                    :polymorphic => true, :accepted_types => %w(Person Company))

    def avatar
      api.avatar(id)
    end

    def permissions
      api.permissions(id)
    end

    private
    def api
      session.users
    end

  end

end
