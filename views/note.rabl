object @note    # replaces note instance of { title: note.title, body: note.body, tags: [{name: tag.name}, {name: tag.name...}] }
attributes :title, :body
child(:tags) { attributes :name }
child(:comments) { attributes :body }
