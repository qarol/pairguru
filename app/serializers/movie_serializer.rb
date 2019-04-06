class MovieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title

  belongs_to :genre
end
