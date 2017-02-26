collection @notes
attributes :title, :body
child :tags do
  attributes :name
end
child :comments do
  attributes :body
end
