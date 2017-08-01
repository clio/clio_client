module ClioClient
  class TaskType < Resource

    set_attributes(id:             {type: :int, readonly: true},
                   created_at:     {type: :datetime, readonly: true},
                   updated_at:     {type: :datetime, readonly: true},
                   name:           {type: :string},
                   enabled:        {type: :boolean}
                   )

    private
    def api
      session.task_types
    end

  end
end
