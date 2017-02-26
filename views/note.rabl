object @note

attributes :title, :body
# node(:tags) { |note| note.tags }

child :tags do
  attributes :name
end
