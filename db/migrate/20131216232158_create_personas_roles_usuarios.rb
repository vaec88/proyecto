class CreatePersonasRolesUsuarios < ActiveRecord::Migration
  def up
    create_table :personas_roles_usuarios, :id => false do |t|
      t.references :persona
      t.references :role
      t.references :usuario
      t.integer :persona_id
      t.integer :role_id
      t.integer :usuario_id
      t.timestamps
    end
    add_index(:personas_roles_usuarios, [:persona_id, :role_id, :usuario_id], :unique => true, :name=>"pers_rol_usu")
  end

  def down
  end
end
