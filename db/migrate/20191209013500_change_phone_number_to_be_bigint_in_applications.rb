class ChangePhoneNumberToBeBigintInApplications < ActiveRecord::Migration[5.1]
  def change
    change_column :applications, :phone_number, :bigint
  end
end
