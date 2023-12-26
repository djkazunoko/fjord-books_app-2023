class AddNotNullConstraintToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_null(:users, :provider, false, '')
    change_column_null(:users, :uid, false, '')
    change_column_default(:users, :provider, from: nil, to: '')
    change_column_default(:users, :uid, from: nil, to: '')
  end
end
