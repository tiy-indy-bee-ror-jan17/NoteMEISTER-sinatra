object @note
attributes :title, :body

child :tags do |tag|
  attribute :name
end
