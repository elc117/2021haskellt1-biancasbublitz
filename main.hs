-- Avaliação 01
-- Bianca Sabrina Bublitz

import Text.Printf

type Circle    = ((Int,Int),Int)

-------------------------------------------------------------------------------
-- Funções auxiliares
-------------------------------------------------------------------------------

-- Le largura da imagem digitada pelo usuário
leLarg :: IO(Int)
leLarg = do 
 putStr "Digite a largura da imagem:  "
 readLn

-- Le altura da imagem digitada pelo usuário
leAlt :: IO(Int)
leAlt = do 
 putStr "Digite a altura da imagem:  "
 readLn

-- Le ponto inicial dos circulos digitado pelo usuário
lePonto :: IO(Int,Int)
lePonto = do 
 putStr "Digite um ponto inicial. Escreva nesse modelo (larg, alt) :  "
 readLn

-- Le raio dos circulos digitada pelo usuário
leRaio :: IO(Int)
leRaio = do 
 putStr "Digite o raio dos circulos:  "
 readLn

-- Verifica, entre dois numeros, qual o menor
menor :: Int -> Int -> Int
menor x y = if x <= y then x else y


-------------------------------------------------------------------------------
-- Paletas
-------------------------------------------------------------------------------

-- Paleta com n valores retirados de uma lista com sequências de R, G e B 
rgbPalette :: Int -> [(Int,Int,Int)]
--rgbPalette n = take n $ cycle [(255,90,90),(90,255,90),(90,90,255)]
rgbPalette n = take n [(255,255,255)]

-------------------------------------------------------------------------------
-- Geração de circulos em suas posições
-------------------------------------------------------------------------------

-- Recebe um ponto de inicio e o raio, e cria um circle
geraUmCirc :: (Int,Int) -> Int -> Circle
geraUmCirc (x,y) raio = ((x,y), raio)

-- Recebe um circle e a quantidade e gera uma lista de circle
genCircs :: Circle -> Int -> Int -> [Circle]
genCircs ((x,y), r) 0 inicial = []
genCircs ((x,y), r) quant inicial = ((x,y), r) : (genCircs ((x,y), r+inicial) (quant-1) inicial)

-------------------------------------------------------------------------------
-- Strings SVG
-------------------------------------------------------------------------------

-- Gera string representando Circulo SVG 
-- dadas coordenadas e dimensões do circulo e uma string com atributos de estilo
svgCirc :: Circle -> String -> String 
svgCirc ((x,y), r) style = 
  printf "<circle cx='%d' cy='%d' r='%d' fill='none' stroke='%s' stroke-width='5' />\n" x y r style

-- String inicial do SVG
svgInicial :: Int -> Int -> String
svgInicial w h = printf "<svg width='%d' height='%d' xmlns='http://www.w3.org/2000/svg'>\n" w h 

-- String final do SVG
svgFinal :: String
svgFinal = "</svg>"

-- Gera string com atributos de estilo para uma dada cor
svgStyle :: (Int,Int,Int) -> String
svgStyle (r,g,b) = printf "rgb(%d,%d,%d)" r g b

-- Gera strings SVG para uma dada lista de figuras e seus atributos de estilo
-- Recebe uma função geradora de strings SVG, uma lista de círculos e strings de estilo
svgElements :: (a -> String -> String) -> [a] -> [String] -> Int -> [String]
svgElements func [] styles quant = []
svgElements func (x:xs) styles quant = concat $ zipWith func [x] styles : [svgElements func xs styles (quant-1)]

-------------------------------------------------------------------------------
-- Função principal que gera arquivo com imagem SVG
-------------------------------------------------------------------------------

main :: IO ()
main = do
  larg <- leLarg
  alt <- leAlt
  ponto <- lePonto
  raio <- leRaio
  let menorNum = menor alt larg
  let numCircs = div (div menorNum raio) 2
      palette = rgbPalette numCircs
      circs = genCircs (geraUmCirc ponto raio) numCircs raio
      svgfigs = svgElements svgCirc circs (map svgStyle palette) numCircs
      svgstrs = concat ([svgInicial larg alt] ++ (svgfigs) ++ [svgFinal])
   in writeFile "img.svg" svgstrs
  