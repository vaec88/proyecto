class PiecesController < ApplicationController
  def index
    @partes = Piece.find(:all)
    @parte = Piece.new
  end

  def new
    @parte = Piece.new
  end

  def create
    @parte = Piece.new(params[:piece])
    if @parte.save
      redirect_to index_piece_path, :notice => "Registrado"
    else
      redirect_to new_piece_path, :notice => "Verificar datos"
    end
  end

  def show
    @parte = Piece.find(params[:id])
  end

  def destroy
    @parte = Piece.find(params[:id])
    @parte.destroy
    redirect_to index_piece_path
  end

  def edit
   @parte = Piece.find(params[:id])
  end

  def update
    @parte = Piece.find(params[:id])
    @parte.update_attributes(params[:piece])
    redirect_to index_piece_path
  end
end
