#!/usr/bin/env ruby
require 'active_record'

# Write your script to setup the database tables here.

class ApplicationMigration < ActiveRecord::Migration[5.0]

  def change
    create_table 'notes', force: true do |t|
      t.text     :title
      t.text     :body
    end
    create_table 'taggings', force: true do |t|
      t.integer  :note_id
      t.integer  :tag_id
    end
    create_table 'tags', force: true do |t|
      t.text     :name
    end
  end

end

# Run 'test' as a command line argument to setup a database for tests
if ARGV[0] == 'test'
  require './test/test_connection.rb'
else
  require './dev_connection.rb'
end
ApplicationMigration.migrate(:up)
