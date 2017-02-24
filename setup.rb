require 'sqlite3'
require 'active_record'

class ApplicationMigration < ActiveRecord::Migration[5.0]

  def change
    create_table :notes, force: true do |t|
      t.string :title
      t.text   :body
    end

    create_table :tags, force: true do |t|
      t.string :name
    end

    create_table :taggings, force: true do |t|
      t.integer :tag_id
      t.integer :note_id
    end

  end

end


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
