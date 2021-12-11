class ChangeColumnNullLabels < ActiveRecord::Migration[5.2]
  def change
    change_column :labels, :label_name, :string, null: false
  end
end
