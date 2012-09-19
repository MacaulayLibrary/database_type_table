# DatabaseTypeTable

Turn database rows into class constants.

## Installation

Add this line to your application's Gemfile:

    gem 'database_type_table'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install database_type_table

## Usage

You may have a few tables with 10 or so rows, where you also
maintain constants in your code. Maybe these tables end with "type".
This gem will create those constants for you. This helps:
* ensure consistent naming
* reduce time comparing database
* manage the database foreign keys

The cost: You will need to restart after changing the database.


For example, given these rows in a table:
```console
  media_type
---------------------------------------------
| id    | name                | created_at  |
---------------------------------------------
| 1     | Audio               | Jan 1, 2000 |
| 2     | Video               | Jan 1, 2000 |
| 3     | Video Without Sound | Jan 1, 2000 |
---------------------------------------------
```

And by including this module in a class:

```ruby
class MediaType
  include DatabaseTypeTable
  database_type_table
end
```


These constants will be created:

```ruby
MediaType::AUDIO_ID                 = 1
MediaType::VIDEO_ID                 = 1
MediaType::VIDEO_WITHOUT_SOUND_ID   = 1
MediaType::AUDIO_NAME               = 'Audio'
MediaType::VIDEO_NAME               = 'Video'
MediaType::VIDEO_WITHOUT_SOUND_NAME = 'Video Without Sound'
MediaType::AUDIO_URL                = 'audio'
MediaType::VIDEO_URL                = 'video'
MediaType::VIDEO_WITHOUT_SOUND_URL  = 'video-without-sound'
```

And these methods are available for iterating through the types

```ruby
MediaType::each_id
MediaType::each_name
MediaType::get_id_from_name
MediaType::get_id_from_name
```

To change the column names for id and name:

```ruby
database_type_table id_column: :asset_format_id, name_column: :asset_format_name
```

If your code calls set_primary_key, primary_key, set_table_name, table_name,
or other methods that alter activerecords interaction with the database,
then you should call those methods before this one:
```console
database_type_table
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

