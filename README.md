# ClioClient

This is an API client for Clio V2.

As we are all aware, the importance of API-level developments is paramount in the cloud-based software industry. Clio’s open API allows you to create valuable add-ons for your clients, and in turn, construct profitable revenue streams for your business.

Please direct any inquiries to the appropriate channel:

    For technical inquiries: api@goclio.com
    For business and partnership inquiries: api.partnerships@goclio.com
    A community driven Clio Developers Google Group also exists where you can connect and ask questions from other Clio API users. For more information visit https://groups.google.com/forum/?fromgroups=#!forum/clio-developers.

We look forward to seeing your developments and creating successful relationships!

More information about the API can be found at http://api-docs.goclio.com/v2/index.html

## Installation

Add this line to your application's Gemfile:

    gem 'clio_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install clio_client

## Usage

You will need to do a few things before you can get started with Clio and the API. For convience, this information is pulled directly from Clio's API documentation at the top.

Sample application using the library: https://github.com/themis/clio-api-demos

### Create a Clio Account

1. Visit http://www.goclio.com/signup/ and create an account.
2. If you are only using your account to develop and test applications, contact api@goclio.com with your login email and we’ll set your account as a developer.

### Create a Clio Application

1. Login to your new Clio account at https://app.goclio.com/session/new
2. Visit our developer portal at https://app.goclio.com/settings/developer_applications
3. Click the Add button to create a new application. Enter details about your application here - these details will be shown to Clio users when they’re asked to authorize your application
4. Make note of the key and the secret, as these will be used to authorize your application with Clio

Now that you have the your key and secret we can begin working. The Key will correspond to `client_id` and the secret will correspond to `client_secret`

To get the access token, you can use the client to generate the authorize url to redirect the user. 

```
client = ClioClient::Session.new({client_id: client_id, client_secret: client_secret})
client.authorize_url("http://mysite.com")
 => https://app.goclio.com/oauth/authorize?response_type=code&client_id=xxxxxxxx&redirect_uri=http%3A%2F%2Fmysite.com
```
Once the authorization has been granted Clio will redirect back to, in this example, `http://mysite.com` with the authorization code in a params `code`

```
client.authorize_with_code "http://mysite.com", code
 => {"access_token"=>"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", "token_type"=>"bearer"} 
client.authorized?
 => true
```

At this point the client is ready to use. You will need to save the `access_token` for future use. 

```
client.access_token = access_token
````

There are many different end points you can now interact with. They all act mostly the same. 

The end points available are on the ClioClient::Session
```
      activities
      activity_descriptions
      bills
      calendar_entries
      calendars
      communications
      contacts
      custom_field_sets
      custom_fields
      document_versions
      documents
      groups
      matters
      notes
      practice_areas
      relationships
      tasks
      timeline_events
      timer
      users
```



#### For endpoints that can "Get all X" 

```
time_entry = client.activities.first(type: 'TimeEntry')
 => #<ClioClient::TimeEntry id: 12059966, created_at: #<DateTime: 2012-04-25T16:16:31+00:00 ((2456043j,58591s,0n),+0s,2299161j)>, updated_at: #<DateTime: 2013-12-14T18:52:45+00:00 ((2456641j,67965s,0n),+0s,2299161j)>, type: "TimeEntry", date: #<Date: 2012-04-25 ((2456043j,0s,0n),+0s,2299161j)>, quantity: 3600.0, price: 10.0, total: "10.0", note: "Do something", billed: false, user_id: 344053630> 
client.activities.list(type: 'TimeEntry').first == time_entry
 => true

```

The amount of data returned is limited, so we can iterate over all of the results. The last query is saved and the next page of results can be accessed like this
```
time_entries = client.activities.list(type: 'TimeEntry')
begin
  do_stuff(time_entries)
  time_entries = client.activities.next_page
end while time_entries.count > 0
```

#### For endpoints that can 'Get a X' there is a `find` method
```
time_entry = client.activities.find(12059966)
 => #<ClioClient::TimeEntry id: 12059966, created_at: #<DateTime: 2012-04-25T16:16:31+00:00 ((2456043j,58591s,0n),+0s,2299161j)>, updated_at: #<DateTime: 2013-12-14T18:52:45+00:00 ((2456641j,67965s,0n),+0s,2299161j)>, type: "TimeEntry", date: #<Date: 2012-04-25 ((2456043j,0s,0n),+0s,2299161j)>, quantity: 3600.0, price: 10.0, total: "10.0", note: "Do something", billed: false, user_id: 344053630> 
```

If we can find an object we can also reload an object to get the current state of the object. This is useful for association on object that return a minimum amount of information
```
time_entry = client.activities.find(12059966)
time_entry.user
 => #<ClioClient::User id: 344053630, name: "Foo Bar"> 

time_entry.user.reload
 => #<ClioClient::User id: 344053630, created_at: #<DateTime: 2012-04-25T15:33:34+00:00 ((2456043j,56014s,0n),+0s,2299161j)>, updated_at: #<DateTime: 2014-01-14T00:30:14+00:00 ((2456672j,1814s,0n),+0s,2299161j)>, subscription_plan: "Attorneys", time_zone: "Indiana (East)", first_name: "Foo", last_name: "Bar", email: "foo@bar.com", enabled: false> 

```

#### For endpoints that have CRUD actions

We can create a new object via
```
time_entry = client.activities.new('type' => 'TimeEntry', 'date' => Date.today)
 => #<ClioClient::TimeEntry type: "TimeEntry", date: #<Date: 2014-01-21 ((2456679j,0s,0n),+0s,2299161j)>> 
```

You can save it with
```
time_entry = client.activities.new('type' => 'TimeEntry', 'date' => Date.today)
 => #<ClioClient::TimeEntry type: "TimeEntry", date: #<Date: 2014-01-21 ((2456679j,0s,0n),+0s,2299161j)>> 
time_entry.save
 => #<ClioClient::TimeEntry id: 51171062, type: "TimeEntry", date: #<Date: 2014-01-21 ((2456679j,0s,0n),+0s,2299161j)>> 

```

To update, you can use the same `save` method. 

To destroy an object you can do
```
time_entry = client.activities.find(51171062)
 => #<ClioClient::TimeEntry id: 51171062, created_at: #<DateTime: 2014-01-22T05:10:50+00:00 ((2456680j,18650s,0n),+0s,2299161j)>, updated_at: #<DateTime: 2014-01-22T05:10:50+00:00 ((2456680j,18650s,0n),+0s,2299161j)>, type: "TimeEntry", date: #<Date: 2014-01-21 ((2456679j,0s,0n),+0s,2299161j)>, quantity: 0.0, price: 0.0, total: "0.0", billed: false, user_id: 344053630> 
time_entry.destroy
 => nil
```





## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
