-- Avaliação 01
-- Bianca Sabrina Bublitz

-------------------------------------------------------------------------------
-- ARQUIVO DE FUNÇÕES
-------------------------------------------------------------------------------

module Funcoes where

import Text.Printf

-- Definição do tipo Circle
type Circle    = ((Int,Int),Int)



-------------------------------------------------------------------------------
-- Funções para Interface
-------------------------------------------------------------------------------

-- Imprime instruções iniciais na tela
interfaceInicial :: IO()
interfaceInicial = do
  putStrLn "--------------------------------------------------------------------------------------------------------------"
  putStrLn "                                    (:   BEM VINDO(A) TERRAQUEO(A)   :)                                       "
  putStrLn "                         este eh um programa de geracao de imagens com arte generativa                         "
  putStrLn "--------------------------------------------------------------------------------------------------------------"
  putStrLn " "
  putStrLn "  -> Ao final da execucao iremos gerar um imagem no formato .svg com o tamanho que voce escolher"
  putStrLn "  -> Neste caso, nosso programa ira trabalhar com circulos"
  putStrLn "  Bora comecar?! Pra isso vou te pedir algumas informacoes"
  putStrLn " "

-- Imprime instruções finais na tela
interfaceFinal :: IO()
interfaceFinal = do
  putStrLn " "
  putStrLn " ... "
  putStrLn " Hmmm, perai, to montando aqui"
  putStrLn " "
  putStrLn "  YAY, TUA IMAGEM TA PRONTINHA :)"
  putStrLn "  Ja gerei o arquivo pra ti, e tu pode visualizar como ficou tua arte generativa acessando o arquivo 'arte_legalzona.svg' "
  putStrLn " "
  putStrLn " Ate maissss terraqueo(a), foi um prazer te receber aqui"


-------------------------------------------------------------------------------
-- Funções auxiliares
-------------------------------------------------------------------------------

-- Gera a largura da imagem
-- Le um valor digitado pelo usuário
leLarg :: IO(Int)
leLarg = do 
 putStr "Digita pra mim a largura da imagem que tu quer (ex: 500):  "
 readLn

-- Gera a altura da imagem
-- Le um valor digitado pelo usuário
leAlt :: IO(Int)
leAlt = do 
 putStr "Ok. Agora digita qual a altura da imagem (ex: 500):  "
 readLn

-- Gera o raio do primeiro circulo
-- Le um valor digitado pelo usuário
leRaio :: IO(Int)
leRaio = do 
 putStr "Ta ficando legal! Mas agora me fala qual o tamanho do raio do primeiro circulo que tu quer (ex: 10):  "
 readLn

-- Gera a saturação das cores RGB 
-- (pois, dependendo do numero, as cores vão mais para o preto (0,0,0) ou para o branco (255,255,255))
-- Le um numero aleatorio digitado pelo usuário 
leAleat :: IO(Int)
leAleat = do 
 putStr "Quase la! Pra finalizar, me diz um numero aleatorio, de 1 a 10, ai (ex: 5):  "
 readLn

-- Retorna o menor valor entre dois numeros
-- Recebe x e y, e compara
menor :: Int -> Int -> Int
menor x y = if x <= y then x else y


-------------------------------------------------------------------------------
-- Paletas
-------------------------------------------------------------------------------

-- Define a paleta de cores
-- Recebe a quantidade de circulos e um numero aleatorio, e cria valor em RGB 
rgbPalette :: Int -> Int -> [(Int,Int,Int)]
rgbPalette 0 r = []
rgbPalette n r 
  | n <= 5 = ((r+n)*2, r+n , r+n) : rgbPalette (n-1) (r+1)
  | n <= 10 = (r+n, (r+n)*2 , r+n) : rgbPalette (n-1) (r+2)
  | n <= 15 = (r+n, r+n , (r+n)*2) : rgbPalette (n-1) (r+4)
  | n <= 20 = (r+n, r+n , r+n) : rgbPalette (n-1) (r+6)
  | n <= 30 = (r+n, r+n , r+n) : rgbPalette (n-1) (r+8)
  | n <= 40 = (r+n, r+n , r+n) : rgbPalette (n-1) (r+10)
  | otherwise = (r+n, r+n , r+n) : rgbPalette (n-1) (r+12)


-------------------------------------------------------------------------------
-- Geração de circulos em suas posições
-------------------------------------------------------------------------------

-- Gera um Circle
-- Recebe um ponto e um raio
geraUmCirc :: (Int,Int) -> Int -> Circle
geraUmCirc (x,y) raio = ((x,y), raio)

-- Gera uma lista de Circles
-- Recebe um circle, a quantidade requisitada e um valor de incrementação
genCircs :: Circle -> Int -> Int -> [Circle]
genCircs ((x,y), r) 0 inicial = []
genCircs ((x,y), r) quant inicial = ((x,y), r) : (genCircs ((x,y), r+inicial) (quant-1) inicial)


-------------------------------------------------------------------------------
-- Strings SVG
-------------------------------------------------------------------------------

-- Gera string representando Circulo SVG 
-- Recebe as coordenadas, asdimensões do circulo e uma string com atributos de estilo
svgCirc :: Circle -> String -> String 
svgCirc ((x,y), r) style = 
  printf "<circle cx='%d' cy='%d' r='%d' fill='none' stroke='%s' stroke-width='3' />\n" x y r style

-- Gera a string inicial do SVG
-- Recebe a altura e largura da imagem
svgInicial :: Int -> Int -> String
svgInicial w h = printf "<svg width='%d' height='%d' xmlns='http://www.w3.org/2000/svg'>\n" w h 

-- Gera a string final do SVG
svgFinal :: String
svgFinal = "</svg>"

-- Gera uma string com atributos de cor
-- Recebe valores int de rgb e transforma para string
svgStyle :: (Int,Int,Int) -> String
svgStyle (r,g,b) = printf "rgb(%d,%d,%d)" r g b

-- Gera strings SVG para uma dada lista de circulos e seus estilos
-- Recebe uma função geradora de strings SVG, uma lista de círculos e uma lista de strings de estilo
svgElements :: (a -> String -> String) -> [a] -> [String] -> [String]
svgElements func [] styles = []
svgElements func circ [] = []
svgElements func (x:xs) (y:ys) = concat $ zipWith func [x] [y] : [svgElements func xs ys]
