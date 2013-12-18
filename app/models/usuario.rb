class Usuario < ActiveRecord::Base
  attr_accessible :usu_username, :usu_password, :usu_foto, :usu_estado, :usu_matr_prof, :usu_pag_web
  #has_many :personas
  #has_and_belongs_to_many :personas
  #has_and_belongs_to_many :roles
  #has_and_belongs_to_many :personas, :join_table => :personas_roles_usuarios
  #has_and_belongs_to_many :roles, :join_table => :personas_roles_usuarios

  has_many :personas_roles_usuarios#, :dependent => :delete_all
  has_many :personas, :through => :personas_roles_usuarios

  has_many :personas_roles_usuarios#, :dependent => :delete_all
  has_many :roles, :through => :personas_roles_usuarios

  has_many :diaries
  has_many :amounts

  has_attached_file :usu_foto,
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
    #:dropbox_options => {environment: ENV["RACK_ENV"]},
    #:default_url => "/images/usuarios/perfil.jpg",
    #:path => ":rails_root/public/images/usuarios/:id/:basename_:style.:extension",
    #:url => "/images/usuarios/:id/:basename_:style.:extension",
    :default_url => "https://dl.dropboxusercontent.com/u/246482361/images/usuarios/perfil.JPG",
    :path => "images/usuarios/:id/:basename_:style.:extension",
    :url => "images/usuarios/:id/:basename_:style.:extension",
    :default_style => :small,
    #:path => ':rails_root/public:url',
	    :styles => {
	      :thumb=> "100x100#",
	      :small  => "150x150>" }
	  # Validaciones de Paperclip
	  validates_attachment_size :usu_foto, :less_than => 2.megabytes
	  validates_attachment_content_type :usu_foto, :content_type => ['image/jpeg', 'image/png']

  #accepts_nested_attributes_for :personas
  #validates_associated :personas
  def self.authenticate(username, password)
    user = find_by_usu_username(username)
    if user && password==user.usu_password
      user
    else
      nil
    end
  end

end
