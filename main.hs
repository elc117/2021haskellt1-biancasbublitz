-- Avaliação 01
-- Bianca Sabrina Bublitz

import Text.Printf

main :: IO ()
main = do
putStrLn "Digite a largura da imagem"
larg <- getLine
putStrLn "Digite a altura da imagem"
alt <- getLine
putStrLn ("Voce digitou " ++ larg ++ " " ++ alt)
