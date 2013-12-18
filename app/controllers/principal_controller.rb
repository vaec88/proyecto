class PrincipalController < ApplicationController

  def index
    @operacion = Operation.find(:all)
    @propiedad = Property.find(:all)
    @provincia = Province.find(:all)
    @partes = Piece.find(:all)
    @canton = []
    @parroquia = []
    #@inmueble = Construction.paginate(:page => params[:page], :per_page => 3)
    @inmueble = Construction.where(:inm_estado => ["A","P"]).paginate(:page => params[:page], :per_page => 8)
    @json = @inmueble.to_gmaps4rails
  end
  def directivos
  end
  def mision
  end
  def vision
  end
  def propiedades
  end
  def novedades
  end
  def falla_sesion
  end
  def ingresaste
  end
  def morosos
  end
  def resena
  end
  def etica
  end
  def ley
  end
  def reglamento
  end
  def contacto
  end
end