class CreateUsuarios < ActiveRecord::Migration
  def up
    create_table :usuarios do |t|
      t.string :usu_username
      t.string :usu_password
      t.string :usu_foto
      t.string :usu_foto_file_name
      t.string :usu_foto_content_type
      t.integer :usu_foto_file_size
      t.string :usu_estado
      t.string :usu_matr_prof
      t.string :usu_pag_web
      t.integer :institution_id
      t.references :institution
      t.timestamps
    end
    add_index(:usuarios, [:institution_id], :name=>"inst_usu")
  end

  def down
  end
end
