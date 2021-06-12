-- Avaliação 01
-- Bianca Sabrina Bublitz

import Text.Printf

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

-- String inicial do SVG
svgInicio :: Int -> Int -> String
svgInicio w h = printf "<svg width='%.2f' height='%.2f' xmlns='http://www.w3.org/2000/svg'>\n" w h 

-- String final do SVG
svgFinal :: String
svgFinal = "</svg>"

svgCircle :: Int -> Int -> Int -> String -> String 
svgCircle x y r style = 
  printf "<circle cx='%d' cy='%d' r='%d' fill='%s' />\n" x y r style

svgAll :: Int -> Int -> String
svgAll x y = 
  svgInicio x y ++ 
  (svgCircle 10 10 50 "rgb(255, 255, 255,0.5)") ++ 
  svgFinal

main :: IO ()
main = do
  larg <- leLarg
  alt <- leAlt
  ponto <- lePonto
  putStrLn "Voce digitou " 
  print larg
  writeFile "circles.svg" (svgAll larg alt)

 {-putStrLn "Digite a largura da imagem"
 larg <- getLine
 putStrLn "Digite a altura da imagem"
 alt <- getLine
 putStrLn "Digite um ponto inicial. Escreva nesse modelo '(larg, alt)'"
 ponto <- getLine
 putStrLn ("Voce digitou " ++ larg ++ " " ++ alt ++ " " ++ ponto)-}
 
        
       
