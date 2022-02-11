class CreatePostWithUniqueTitle < ActiveRecord::Migration[6.1]
  def change
    create_table :post_with_unique_titles do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
    add_index :post_with_unique_titles, :title, unique: true
  end
end
