class CreatePeopleSubjects < ActiveRecord::Migration
  def change
    create_table :people_subjects do |t|
      t.text :first_name
      t.text :last_name
      t.text :external_link
      t.references :user, index: true

      t.timestamps null: false
    end
     add_index :people_subjects, [:user_id, :created_at]
  end
end
