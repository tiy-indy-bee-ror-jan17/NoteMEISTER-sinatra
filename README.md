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

- TTY is used for the command line interface.

- And, of course, Ruby for, well... everything.

### Unfinished:

The Only thing left unfinished is comments. Much of the groundwork is done.

There is commented out code in the app, rabl note template, and the setup file that should enable comments to be created through a `post` endpoint, added to a particular note in the table, and returned in json format with it's note.

The only thing left unfinished is tweaking the command line interface to post and display comments, as well as adding tests and tweaking old tests to account for comments.

Finishing the CLI to support comments should be relatively straight forward. Display is basically just adding an attribute to display. adding a post option is a bit more complicated, but it involves adding a selectable option, taking user input, creating the post command, and parsing the response. Much of which is similar to the existing post request code.

Honestly I believe tweaking the old tests to be most difficult part, mostly because it involves wrapping my head around how all of the setup with unfamiliar test-stuff works. Creating robust new tests could be tricky too, especially if I want to follow and include those same unfamiliar parts of the current tests.
