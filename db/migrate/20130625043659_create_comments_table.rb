class CreateCommentsTable < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :post

      t.timestamps
    end
  end

end