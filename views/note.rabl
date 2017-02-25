object @note
attributes :title, :body
child :tags do |tag|
  attributes :name
end
