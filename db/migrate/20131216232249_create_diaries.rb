class CreateDiaries < ActiveRecord::Migration
  def up
    create_table :diaries do |t|
      t.string :age_actividad
      t.datetime :age_fecha
      t.datetime :age_hora
      t.string :age_direccion
      t.references :usuario
      t.integer :usuario_id
      t.timestamps
    end
    add_index(:diaries, [:usuario_id], :name=>"usu_age")
  end

  def down
  end
end
