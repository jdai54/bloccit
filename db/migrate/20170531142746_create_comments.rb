class CreateComments < ActiveRecord::Migration
  def change
    # the create_table method takes a "Symbol" argument which represents the table name, and a bloc argument that contains the details of the added table
    create_table :comments do |t|
      t.text :body
      # #1 the "index" on the references line tells the database to index the "post_id" column, so it can be searched efficiently. This is always a good idea for foreign keys and is added automatically when you generate the referneces argument
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
