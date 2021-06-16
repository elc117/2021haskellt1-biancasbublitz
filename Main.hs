-- Avaliação 01
-- Bianca Sabrina Bublitz

import Funcoes

-------------------------------------------------------------------------------
-- ARQUIVO COM FUNÇÃO PRINCIPAL QUE GERA OUTRO ARQUIVO COM IMAGEM SVG
-------------------------------------------------------------------------------

main :: IO ()
main = do
  -- Imprime a interface inicial
  interfaceInicial

  -- Faz a leitura dos valores
  larg <- leLarg
  alt <- leAlt
  raio <- leRaio
  numAleat <- leAleat

  -- Gera o ponto inicial, que sempre será o centro da imagem
  let ponto = ((div larg 2),(div alt 2))

  -- Descobre qual a menor dimensao da imagem: alt ou larg
  let menorNum = menor alt larg 

  -- calcula o número de circulos conforme o tamanho disponivel na imagem
  let numCircs = div (div menorNum raio) 2  

      -- palette = lista com tamanho numCircs, que guarda os valores rgb
      palette = rgbPalette numCircs (numAleat*10)

      -- circs = lista com tamanho numCircs, que guarda o ponto incial e o raio de cada circulo
      circs = genCircs (geraUmCirc ponto raio) numCircs raio

      -- svgfigs = string svg com todas as infomações (ponto inicial, raio e cores) de cada circulo
      svgfigs = svgElements svgCirc circs (map svgStyle palette)

      -- svgstrs = junção da string inicial com a string dos circulos com a string final
      svgstrs = concat ([svgInicial larg alt] ++ (svgfigs) ++ [svgFinal])

  -- o arquivo "arte_legalzona.svg" é gerado aqui, com base no conteúdo de svgstrs
   in writeFile "arte_legalzona.svg" svgstrs

  -- Imprime a interface inicial
  interfaceFinal
  