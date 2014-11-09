class CreatePeopleComments < ActiveRecord::Migration
  def change
    create_table :people_comments do |t|
      t.text :content
      t.references :user, index: true
      t.references :people_subject, index: true

      t.timestamps null: false
    end
  add_index :people_comments, [:people_subject_id, :created_at]
  add_index :people_comments, [:user_id, :created_at]
  end
end
