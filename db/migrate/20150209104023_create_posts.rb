class CreatePosts < ActiveRecord::Migration
  def change
    create_table :blogpostify_posts do |t|
      t.string :blog
      t.string :title
      t.text :description
      t.string :guid
      t.string :link
      t.timestamp :published_at

      t.timestamps
    end
  end
end
