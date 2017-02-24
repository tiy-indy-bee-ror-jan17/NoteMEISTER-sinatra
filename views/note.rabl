object @note    # replaces note instance of { title: note.title, body: note.body, tags: [{name: tag.name}, {name: tag.name...}] }
attributes :title, :body
child :tags do   # child is needed because notes has_many tags
  attributes :name
end
