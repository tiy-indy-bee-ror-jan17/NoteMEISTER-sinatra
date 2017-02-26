# app/views/gets/notes.rabl
object @notes
attributes :title, :body
child :tags do attributes :name end
