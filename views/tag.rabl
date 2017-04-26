object @tag
attributes :name
child :notes do   # a tag has_many notes
  attributes :title, :body
  child :comments do
    attributes :body
  end
  child :tags do   # child needed because notes has_many tags..........................
    attributes :name
  end
end
