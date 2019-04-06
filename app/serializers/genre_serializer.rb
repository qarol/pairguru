class GenreSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name
  attribute(:movies_count) { |object| object.movies.size }
end
