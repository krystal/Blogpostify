class CreatePosts < ActiveRecord::Migration
  def change
    create_table :blogpostify_posts, force: true do |t|
      t.string :blog_id
      t.string :title
      t.text :description
      t.string :guid
      t.string :link
      t.timestamp :published_at

      t.timestamps
    end

    add_index :blogpostify_posts, :blog_id
  end
end
