class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :picture
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
