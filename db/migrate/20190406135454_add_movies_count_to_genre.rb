class AddMoviesCountToGenre < ActiveRecord::Migration[5.2]
  def change
    add_column :genres, :movies_count, :integer
  end
end
