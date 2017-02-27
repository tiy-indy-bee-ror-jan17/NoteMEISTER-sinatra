require 'active_record'

# Write your script to setup the database tables here.

class ApplicationMigration < ActiveRecord::Migration[5.0]
  def change
    create_table :tags, force: true do |t|
      t.text :name
    end

    create_table :taggings, force: true do |t|
      t.integer :tag_id
      t.integer :note_id
    end

    create_table :notes, force: true do |t|
      t.text :title
      t.text :body
      t.text :comments
      t.text :tags
    end
  end
end

# Run it command line arguments of `dev` or `test` to setup a database for dev or tests
if ARGV[0] == 'dev'
  ActiveRecord::Base.establish_connection(
    adapter:  'sqlite3',
    database: 'db/development.sqlite3'
  )
  ApplicationMigration.migrate(:up)
elsif ARGV[0] == 'test'
  ActiveRecord::Base.establish_connection(
    adapter:  'sqlite3',
    database: 'db/test.sqlite3'
  )
  ApplicationMigration.migrate(:up)
end

# faking changes
