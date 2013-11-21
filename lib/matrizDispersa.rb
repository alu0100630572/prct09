
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

end
