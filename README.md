# NoteMEISTER 5000

## Homework: Develop basic tubular NoteMEISTER 5000 API on Sinatra.

Run `rake test` to run the tests.

And `bundle` to install the basic dependencies.

Run `ruby app.rb` to start the server.

Run `ruby interface.rb` from inside the `CLI` folder to run the command line interface.

It uses `HTTParty` to use the API endpoints, and displays the results.

### Endpoints are:

- `GET` at `/api/notes.json` returns all the notes.
- `GET` at `/api/notes/tag/YOUR_TAG_HERE` returns all the notes that are tagged with YOUR_TAG_HERE.
- `POST` at `/api/notes` lets you create a new note. It returns that note.


## Techincal Details

- This API runs on Sinatra, which is running a puma server.

- Rabl is used for creating json templates.

- Sqlite3 is the database, with Active Record.

- And, of course, Ruby for, well... everything.
