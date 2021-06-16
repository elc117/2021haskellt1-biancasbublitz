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
rgbPalette :: Int -> Int -> [(Int,Int,Int)]
rgbPalette 0 r = []
rgbPalette n r 
  | n <= 5 = (r^2, r , r) : rgbPalette (n-1) (r+1)
  | n <= 10 = (r, r^2 , r) : rgbPalette (n-1) (r+2)
  | n <= 15 = (r, r , r^2) : rgbPalette (n-1) (r+3)
  | n <= 20 = (r, r , r) : rgbPalette (n-1) (r+4)
  | n <= 30 = (r, r , r) : rgbPalette (n-1) (r+6)
  | n <= 40 = (r, r , r) : rgbPalette (n-1) (r+8)
  | otherwise = (r, r , r) : rgbPalette (n-1) (r+10)
{-
rgbPalette 20 r = (r^2, r , r^2) : rgbPalette (20-1) (r+2)
rgbPalette n r = (r, r , r) : rgbPalette (n-1) (r+8)-}

semVogais (x:xs)
   | elem x "aeiou" = semVogais xs
   | otherwise      = x : semVogais xs

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
  printf "<circle cx='%d' cy='%d' r='%d' fill='none' stroke='%s' stroke-width='3' />\n" x y r style

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
svgElements :: (a -> String -> String) -> [a] -> [String] -> [String]
svgElements func [] styles = []
svgElements func circ [] = []
svgElements func (x:xs) (y:ys) = concat $ zipWith func [x] [y] : [svgElements func xs ys]

-------------------------------------------------------------------------------
-- Função principal que gera arquivo com imagem SVG
-------------------------------------------------------------------------------

main :: IO ()
main = do
  larg <- leLarg
  alt <- leAlt
  raio <- leRaio
  let ponto = ((div larg 2),(div alt 2))
  let menorNum = menor alt larg
  let numCircs = div (div menorNum raio) 2
      palette = rgbPalette numCircs raio
      circs = genCircs (geraUmCirc ponto raio) numCircs raio
      svgfigs = svgElements svgCirc circs (map svgStyle palette)
      svgstrs = concat ([svgInicial larg alt] ++ (svgfigs) ++ [svgFinal])
   in writeFile "img.svg" svgstrs
  