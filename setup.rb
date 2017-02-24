require 'sqlite3'
require 'active_record'


# Write your script to setup the database tables here.

class NoteMigration < ActiveRecord::Migration[5.0]
  def change
    create_table "notes", force: true do |t|
       t.text    "title"
       t.text    "body"
    end

    create_table "tags", force: true do |t|
       t.text    "name"
    end

    create_table "taggings", force: true do |t|
       t.integer    "note_id"
       t.integer    "tag_id"
    end
  end
end

#NoteMigration.migrate(:up)
#Ipsum.create(identifier: "hipster",  paragraph: "Mustache forage trust fund, austin cold-pressed man bun")


# ------------ end of code I am inserting --------

class ApplicationMigration < ActiveRecord::Migration[5.0]

end

# Run it command line arguments of `dev` or `test` to setup a database for dev or tests
if ARGV[0] == 'dev'
  ActiveRecord::Base.establish_connection(
    adapter:  'sqlite3',
    database: 'db/development.sqlite3'
  )
  NoteMigration.migrate(:up)
elsif ARGV[0] == 'test'
  ActiveRecord::Base.establish_connection(
    adapter:  'sqlite3',
    database: 'db/test.sqlite3'
  )
  NoteMigration.migrate(:up)
end
