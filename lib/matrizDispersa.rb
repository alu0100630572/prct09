
require 'matriz.rb'
require 'matrizDensa.rb'

class MatrizDispersa < Matriz

  attr_accessor :nFil, :mCol, :matriz

  def initialize(n, m, matriz)
    @nFil = n
    @mCol = m
    @matriz = matriz
  end
  
  def coerce(matriz)
    [self, matriz]
  end 

  def to_s
    matString = ""
    for i in 0...@nFil do
      for j in 0...@mCol do
        if ((!@matriz[i].nil?) && (!@matriz[i][j].nil?))
          matString = matString + @matriz[i][j].to_s + " "
        else
          matString = matString + "0 "
        end
      end
      matString = matString + "\n"
    end
    matString
  end
  
  def tras
    aux = MatrizDispersa.new(@mCol, @nFil, {})
    for i in 0...@nFil do
      for j in 0...@mCol do
        if ((!@matriz[j].nil?) && (!@matriz[j][i].nil?))
            if (aux.matriz[i].nil?)
              aux.matriz[i] = {}
            end
          aux.matriz[i][j] = @matriz[j][i]
        end
      end
    end
    aux
  end

  def det
    if (@nFil == @mCol)
      if ((!@matriz[0].nil?) && (!@matriz[0][0].nil?))
        det = @matriz[0][0]
      else
        det = 0
      end
      aux = MatrizDispersa.new(@nFil, @mCol, @matriz)
      for k in 0...@nFil do
        l = k+1
        for i in l...@mCol do
          for j in l...@mCol do
            aux.matriz[i][j] = (aux.matriz[k][k] * aux.matriz[i][j] - aux.matriz[k][j] * aux.matriz[i][k])/ aux.matriz[k][k]
          end
        end
        det = det * aux.matriz[k][k]
      end
    else
      det = "ERROR, la matriz no es cuadrada"
    end
    det
  end

  def x(escalar)                #multiplicacion por un escalar
    aux = MatrizDispersa.new(@nFil, @mCol, @matriz)
    for i in 0...@nFil do
      for j in 0...@mCol do
        if ((!@matriz[i].nil?) && (!@matriz[i][j].nil?))
          aux.matriz[i][j] = @matriz[i][j] * escalar
        end
      end
    end
    aux
  end
end
