#! /usr/local/ruby/bin/ruby 
# require 'racional.rb'
require 'matriz.rb'

class MatrizDensa < Matriz

  attr_accessor :nFil , :mCol, :matriz

  def initialize (matriz)
    @nFil = matriz.size
    @mCol = matriz[0].size
    @matriz = matriz
  end

 # def coerce(matriz)
#    [self, matriz]
#  end

  def to_s
    matString = ""
    for i in 0...@nFil do
      for j in 0...@mCol do
        matString = matString + @matriz[i][j].to_s + " "
      end
      matString = matString + "\n"
    end
    matString
  end
  
  # Metodo para calcular el determinante de una matriz
  def det
    if (@nFil == @mCol)
    det = @matriz[0][0]
    aux = MatrizDensa.new(@matriz)
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

  # Método apra calcular la traspuesta de una matriz
  def tras
    result = Array.new
      for i in 0...@nFil do
        result[i] = Array.new
        for j in 0...@mCol do
          result[i][j] = 0
        end
      end

    aux = MatrizDensa.new(result)
    for i in 0...@nFil do
      for j in 0...@mCol do
        aux.matriz[i][j] = @matriz[j][i]
      end
    end
    aux
  end
  
  # Metodo para multiplicar una matriz por un escalar
  def x(escalar)
    aux = MatrizDensa.new(@matriz)
    for i in 0...@nFil do
      for j in 0...@mCol do
        aux.matriz[i][j] = @matriz[i][j] * escalar
      end
    end
    aux
  end

  #Metodo apra sumar dos matrices
  def +(mat)
    if (mat.nFil == @nFil && mat.mCol == @mCol)
      aux = MatrizDensa.new(@matriz)
      for i in 0...@nFil do
        for j in 0...@mCol do
          aux.matriz[i][j] = @matriz[i][j] + mat.matriz[i][j]
        end
      end
    else
      aux = 0
    end
    aux
  end

  # Metodo para restar dos matrices
  def -(mat)
    if (mat.nFil == @nFil && mat.mCol == @mCol)
      aux = MatrizDensa.new(@matriz)
      for i in 0...@nFil do
        for j in 0...@mCol do
          aux.matriz[i][j] = @matriz[i][j] - mat.matriz[i][j]
        end
      end
    else
      aux = 0
    end
    aux
  end

  # Metodo para multiplicar dos matrices
  def *(mat)
    if (@mCol == mat.nFil)
      result = Array.new
      for i in 0...@nFil do
        result[i] = Array.new
        for j in 0...mat.mCol do
          if (mat.matriz[0][0].class == Fraccion)
           result[i][j] = Fraccion.new(0, 1)
          else
           result[i][j] = 0
          end
        end
      end

      aux = MatrizDensa.new(result)

      for i in 0...@nFil do
        for j in 0...mat.mCol do
          for z in 0...@mCol do
            aux.matriz[i][j] += @matriz[i][z] * mat.matriz[z][j]
          end
        end
      end
    else
      aux = 0
    end
    aux
  end

  def <=>(matriz)
    if (@nFil == matriz.nFil && @mCol == matriz.mCol)
      comparacion = 0
      for i in 0...@nFil do
        for j in 0...@mCol do
          comparacion += @matriz[i][j] <=> matriz.matriz[i][j]
        end
      end
    end
    if (comparacion > 0)
      comparacion = 1
    elsif (comparacion < 0)
      comparacion = -1
    end
    comparacion
  end

  def max
    maxi = @matriz[0][0]
    for i in 0...@nFil do
      for j in 0...@mCol do
          if (maxi < @matriz[i][j])
            maxi = @matriz[i][j]
          end
        
      end
    end
    maxi
  end

  def min
    mini = @matriz[0][0]
    for i in 0...@nFil do
      for j in 0...@mCol do
          if (mini > @matriz[i][j])
            mini = @matriz[i][j]
          end
      end
    end
    mini
  end
end

