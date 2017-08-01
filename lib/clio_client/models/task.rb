module ClioClient
  class Task < Resource

    set_attributes(id:             {type: :int, readonly: true},
                   created_at:     {type: :datetime, readonly: true},
                   updated_at:     {type: :datetime, readonly: true},
                   name:           {type: :string},
                   description:    {type: :string},
                   priority:       {type: :string},
                   time_estimated: {type: :int},
                   due_at:         {type: :date},
                   complete:       {type: :boolean},
                   complete_at:    {type: :date},
                   is_private:     {type: :boolean},
                   is_statute_of_limitations:   {type: :boolean}
                   )

    has_association :user, ClioClient::User
    has_association :assigner, ClioClient::User
    has_association :matter, ClioClient::Matter
    has_many_association :reminders, ClioClient::Reminder


    private
    def api
      session.tasks
    end

  end
end
