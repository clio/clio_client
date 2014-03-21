module ClioClient

  class Matter < Resource
    
    set_attributes(id:                    {type: :int, readonly: true},
                   created_at:            {type: :datetime, readonly: true},
                   updated_at:            {type: :datetime, readonly: true},
                   display_number:        {type: :string },
                   status:                {type: :string, required: true},
                   description:           {type: :string, required: true},
                   client_reference:      {type: :string},
                   location:              {type: :string},
                   pending_date:          {type: :date},
                   open_date:             {type: :date},
                   close_date:            {type: :date},
                   billable:              {type: :boolean},
                   maildrop_address:      {type: :int, readonly: true},
                   )

    alias_method :name, :display_number
    alias_method :name=, :display_number=

    has_association(:client,            ClioClient::Contact, 
                    :polymorphic => true, :accepted_types => %w(Person Company))
    has_association :responsible_attorney, ClioClient::User
    has_association :practice_area,        ClioClient::PracticeArea
    has_many_association(:custom_field_values, ClioClient::CustomFieldValue, 
        :polymorphic => true, 
        :accepted_types => %w(CustomFieldCheckboxValue CustomFieldContactValue 
        CustomFieldCurrencyValue CustomFieldDateValue CustomFieldTimeValue 
        CustomFieldEmailValue CustomFieldMatterValue CustomFieldNumericValue 
        CustomFieldPicklistValue CustomFieldTextAreaValue 
        CustomFieldTextLineValue CustomFieldUrlValue))

    has_association(:permission, ClioClient::Resource, 
                    :polymorphic => true, 
                    :accepted_types => %w(Group User))

    has_many_association :activity_rates,      ClioClient::Rate
    has_association :flat_rate_activity,       ClioClient::Rate
    has_association :flat_rate_activity_description, ClioClient::ActivityDescription

    private
    def api
      session.matters
    end

  end
end
