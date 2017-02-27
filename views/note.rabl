object @note
attributes :title, :body
child :tags do |tag|
  attributes :name
end
# child :comments do |c|
#   attributes :text
# end
