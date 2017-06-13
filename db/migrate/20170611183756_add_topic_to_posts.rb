class AddTopicToPosts < ActiveRecord::Migration
  def change
    # #5 see that the name we gave the migration, "AddTopicToPosts", is very important. We instructed the generator to create a migration that adds a topic_id column to the posts table. This is the format: "Add" + [table whose id we want to add] + "To" + [table we want to add the foreign key to]
    add_column :posts, :topic_id, :integer
    # #6 created an index on topic_id with the generator. An index imporves the speed of operations on a database table. Foreign key columns should always be indexed
    add_index :posts, :topic_id
  end
end
