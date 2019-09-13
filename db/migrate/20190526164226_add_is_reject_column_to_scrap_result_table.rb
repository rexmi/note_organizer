class AddIsRejectColumnToScrapResultTable < ActiveRecord::Migration[5.2]
  def change
    add_column :scrap_results, :is_reject, :boolean, default: false
  end
end
