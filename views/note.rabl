object @note
attributes :title, :body#, :comment
child :tags do |tag|
  attribute :name
end
