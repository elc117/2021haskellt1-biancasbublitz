-- Avaliação 01
-- Bianca Sabrina Bublitz

import Text.Printf
--import System.Random (randomRIO)

leLarg :: IO(Int)
leLarg = do 
 putStr "Digite a largura da imagem:  "
 readLn

leAlt :: IO(Int)
leAlt = do 
 putStr "Digite a altura da imagem:  "
 readLn

lePonto :: IO(Int,Int)
lePonto = do 
 putStr "Digite um ponto inicial. Escreva nesse modelo (larg, alt) :  "
 readLn

leRaio :: IO(Int)
leRaio = do 
 putStr "Digite o raio dos circulos:  "
 readLn

corAleat :: String
corAleat = "rgb(255, 255, 255, 1)"

criaCirc :: Int -> Int -> Int -> Int -> Int -> String
criaCirc larg alt x y raio = (svgCircle x y raio corAleat)

-- String inicial do SVG
svgInicio :: Int -> Int -> String
svgInicio w h = printf "<svg width='%d' height='%d' xmlns='http://www.w3.org/2000/svg'>\n" w h 

-- String final do SVG
svgFinal :: String
svgFinal = "</svg>"

svgCircle :: Int -> Int -> Int -> String -> String 
svgCircle x y r cor = 
  printf "<circle cx='%d' cy='%d' r='%d' fill='none' stroke='%s' stroke-width='5' />\n" x y r cor

svgAll :: Int -> Int -> (Int,Int) -> Int -> String
svgAll larg alt (x,y) raio = 
  svgInicio larg alt ++ 
  (criaCirc larg alt x y raio) ++ 
  (criaCirc larg alt x y (raio*2)) ++ 
  svgFinal

main :: IO ()
main = do
  larg <- leLarg
  alt <- leAlt
  ponto <- lePonto
  raio <- leRaio
  writeFile "circles.svg" (svgAll larg alt ponto raio)
