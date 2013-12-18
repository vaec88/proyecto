class CreateAmounts < ActiveRecord::Migration
  def up
    create_table :amounts do |t|
      t.decimal :amo_cantidad
      t.string :amo_mes
      t.integer :amo_anio
      t.datetime :amo_fecha
      t.references :usuario
      t.integer :usuario_id
      t.timestamps
    end
    add_index(:amounts, [:usuario_id], :name=>"usu_amo")
  end

  def down
  end
end
