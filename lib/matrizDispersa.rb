
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
  
  def +(mat)
    if (mat.nFil == @nFil && mat.mCol == @mCol)
      result = Array.new
      for i in 0...@nFil do
        result[i] = Array.new
        for j in 0...@mCol do
          result[i][j] = 0
        end
      end
      aux = MatrizDensa.new(result)
      nElementos = 0
      if (mat.class == MatrizDispersa)
      for i in 0...@nFil do
        for j in 0...@mCol do
          if ((!@matriz[i].nil?) && (!@matriz[i][j].nil?) && (!mat.matriz[i].nil?) && (!mat.matriz[i][j].nil?))
            aux.matriz[i][j] = @matriz[i][j] + mat.matriz[i][j]
            nElementos += 1
          elsif ((!@matriz[i].nil?) && (!@matriz[i][j].nil?) && ((mat.matriz[i].nil?) || ((!mat.matriz[i].nil?) && mat.matriz[i][j].nil?)))
            aux.matriz[i][j] = @matriz[i][j]
            nElementos += 1
          elsif ((!mat.matriz[i].nil?) && (!mat.matriz[i][j].nil?) && ((@matriz[i].nil?) || ((!@matriz[i].nil?) && @matriz[i][j].nil?)))
            aux.matriz[i][j] = mat.matriz[i][j]
            nElementos += 1
          end
        end
      end
      elsif (mat.class == MatrizDensa)
      for i in 0...@nFil do
        for j in 0...@mCol do
          if ((!@matriz[i].nil?) && (!@matriz[i][j].nil?))
            aux.matriz[i][j] = @matriz[i][j] + mat.matriz[i][j]
            nElementos += 1
          elsif ((@matriz[i].nil?) || ((!@matriz[i].nil?) && @matriz[i][j].nil?))
            aux.matriz[i][j] = mat.matriz[i][j]
            nElementos += 1
          end
        end
      end
      end
      if ((@nFil * @mCol) * 0.4 > nElementos)
        aux = to_dispersa(aux)
      end
    else
      aux = "No se pueden sumar"
    end
    aux
  end

  def -(mat)
    if (mat.nFil == @nFil && mat.mCol == @mCol)
      result = Array.new
      for i in 0...@nFil do
        result[i] = Array.new
        for j in 0...@mCol do
          result[i][j] = 0
        end
      end
      aux = MatrizDensa.new(result)
      nElementos = 0
      if (mat.class == MatrizDispersa)
      for i in 0...@nFil do
        for j in 0...@mCol do
          if ((!@matriz[i].nil?) && (!@matriz[i][j].nil?) && (!mat.matriz[i].nil?) && (!mat.matriz[i][j].nil?))
            aux.matriz[i][j] = @matriz[i][j] - mat.matriz[i][j]
            nElementos += 1
          elsif ((!@matriz[i].nil?) && (!@matriz[i][j].nil?) && ((mat.matriz[i].nil?) || ((!mat.matriz[i].nil?) && mat.matriz[i][j].nil?)))
            aux.matriz[i][j] = @matriz[i][j]
            nElementos += 1
          elsif ((!mat.matriz[i].nil?) && (!mat.matriz[i][j].nil?) && ((@matriz[i].nil?) || ((!@matriz[i].nil?) && @matriz[i][j].nil?)))
            aux.matriz[i][j] = - mat.matriz[i][j]
            nElementos += 1
          end
        end
      end
      elsif (mat.class == MatrizDensa)
      for i in 0...@nFil do
        for j in 0...@mCol do
          if ((!@matriz[i].nil?) && (!@matriz[i][j].nil?))
            aux.matriz[i][j] = @matriz[i][j] - mat.matriz[i][j]
            nElementos += 1
          elsif ((@matriz[i].nil?) || ((!@matriz[i].nil?) && @matriz[i][j].nil?))
            aux.matriz[i][j] = - mat.matriz[i][j]
            nElementos += 1
          end
        end
      end
      end

      if ((@nFil * @mCol) * 0.4 > nElementos)
        aux = to_dispersa(aux)
      end
    else
      aux = "No se pueden sumar"
    end
    aux
  end

  def *(mat)
    if (@mCol == mat.nFil)
      result = Array.new
      for i in 0...@nFil do
        result[i] = Array.new
        for j in 0...@mCol do
          result[i][j] = 0
        end
      end
      aux = MatrizDensa.new(result)
      nElementos = 0
      if (mat.class == MatrizDispersa)
      for i in 0...@nFil do
        for j in 0...mat.mCol do
          for z in 0...@mCol do
            if ((!@matriz[i].nil?) && (!@matriz[i][z].nil?) && (!mat.matriz[z].nil?) && (!mat.matriz[z][j].nil?))
              aux.matriz[i][j] += @matriz[i][z] * mat.matriz[z][j]
              nElementos += 1
            end
          end
        end
      end
      else
      for i in 0...@nFil do
        for j in 0...mat.mCol do
          for z in 0...@mCol do
            if ((!@matriz[i].nil?) && (!@matriz[i][z].nil?))
              aux.matriz[i][j] += @matriz[i][z] * mat.matriz[z][j]
              nElementos += 1
            end
          end
        end
      end
      end
      if ((@nFil * @mCol) * 0.4 > nElementos)
        aux = to_dispersa(aux)
      end
    else
      aux = "No se pueden multiplicar"
    end
    aux
  end

  def <=>(mat)
    if (@nFil == mat.nFil && @mCol == mat.mCol)
      comparacion = 0
      for i in 0...@nFil do
        for j in 0...@mCol do
          if ((!@matriz[i].nil?) && (!@matriz[i][j].nil?) && (!mat.matriz[i].nil?) && (!mat.matriz[i][j].nil?))
            comparacion += @matriz[i][j] <=> mat.matriz[i][j]
          elsif ((!@matriz[i].nil?) && (!@matriz[i][j].nil?) && ((mat.matriz[i].nil?) || ((!mat.matriz[i].nil?) && mat.matriz[i][j].nil?)))
            if (@matriz[i][j] > 0)
              comparacion += 1
            elsif (@matriz[i][j] < 0)
              comparacion -= 1
            end
          elsif ((!mat.matriz[i].nil?) && (!mat.matriz[i][j].nil?) && ((@matriz[i].nil?) || ((!@matriz[i].nil?) && @matriz[i][j].nil?)))
            if (mat.matriz[i][j] > 0)
              comparacion -= 1
            elsif (mat.matriz[i][j] < 0)
              comparacion += 1
            end
          end
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
    maxi = 0
    for i in 0...@nFil do
      for j in 0...@mCol do
        if ((!@matriz[i].nil?) && (!@matriz[i][j].nil?))
          if (maxi < @matriz[i][j])
            maxi = @matriz[i][j]
          end
        end
      end
    end
    maxi
  end

  def min
    mini = 0
    for i in 0...@nFil do
      for j in 0...@mCol do
        if ((!@matriz[i].nil?) && (!@matriz[i][j].nil?))
          if (mini > @matriz[i][j])
            mini = @matriz[i][j]
          end
        end
      end
    end
    mini
  end

  def to_dispersa(matDen)
    result = {}
    for i in 0...matDen.nFil do
      for j in 0...matDen.mCol do
        if (matDen.matriz[i][j] != 0)
          if (result[i].nil?)
            result[i] = {}
          end
          result[i][j] = matDen.matriz[i][j]
        end
      end
    end
    aux = MatrizDispersa.new(matDen.nFil, matDen.mCol, result)
  end
end
