# app/views/gets/notes.rabl
object @noter
attributes :title, :body
child (:tags) { name :name }
