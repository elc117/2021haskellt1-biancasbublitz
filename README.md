Avaliação 01 - Bianca Sabrina Bublitz

README


* Introdução
--

  Para realizar o trabalho, foram utilizados os conhecimentos adquiridos na própria disciplina, tanto através dos conteúdos em vídeos e slides, como o que conhecemos na parte prática. E, além destes, foram utilizados alguns materiais extras, mencionados no fim deste documento.

Iniciei o estudo para o trabalho com as atividades que já havia realizado em aula, analisando, principalmente, os arquivos da atividade 04 (1, 3), que também tratava sgv. Por segundo, pesquisei o uso de entradas e saídas de dados (4). Com o entendimento destas duas etapas, passei a testar especificamente as strings svg's, compreendendo ainda mais o seu funcionamento (2, 5). Baseando-se nesses aprendizados, passei a implementar mais funções com let/in, recursividade e list comprehension (3), para diversificar as saídas do svg de acordo com as entradas recebidas. Fiz alguns testes para entender o que funcionava melhor para cada parte. 

Por último, implementei uma interface com informações ao usuário, comentei todo o código, para melhor entendimento, e dividi as funções em dois arquivos: o Main.hs, com a função principal, e o Funcoes.hs que possuem as funções auxiliares ao Main.


* Uso do programa
--

  Para utilizar o programa é necessária a compilação do mesmo. Após esta etapa, chama-se o "main".

O programa imprimirá na tela as boas-vindas e algumas informações ao usuário.
Depois, irá pedir alguns dados, como:
  altura que deseja que a imagem tenha; largura que deseja que a imagem tenha; o tamanho do raio que deseja no primeiro círculo e um valor aleatório -que servirá de base para as cores da imagem. Nenhum destes valores precisa ser seguido de alguma medida (cm, m...), necessita-se apenas dos números, conforme os exemplos dados. 

Com os dados coletados, o programa gera um arquivo svg chamado "arte_legalzona.svg". 
Essa imagem terá n circunferências de círculos, onde n será calculado conforme o tamanho da imagem que se deseja e o raio passado. As suas cores serão calculadas com base no valor aleatório passado, de forma que: quanto mais perto de 10 (valor máximo) as cores são mais claras, pois os valores de RGB se aproximam de (255,255,255) que representa o branco; e quanto mais perto de 1 (valor mínimo) as cores são mais escuras, pois os valores de RGB se aproximam de (0,0,0) que representa o preto.

A imagem gerada com altura = 500, largura = 500, raio do primeiro círculo = 10 e cor aleatória = 5 é a que está neste repositório com o nome "exemplo.sgv"


* Créditos
--

  Conteúdos acessados para realização do trabalho:

1. Exercícios anteriores desta disciplina (https://github.com/AndreaInfUFSM/elc117-2021a);

2. Links disponibilizados pela professora (https://www.w3schools.com/graphics/svg_intro.asp) (http://learnyouahaskell.com/starting-out#tuples);

3. Material da Universidade Federal de Ouro Preto (http://www.facom.ufu.br/~madriana/PF/IOHaskell.pdf
) (http://www.decom.ufop.br/romildo/2017-2/bcc222/slides/progfunc.pdf) (http://www.facom.ufu.br/~madriana/PF/AulaCap6.pdf);

4. Conteúdo sobre entradas e saídas em Haskell (Haskell/Entradas e saídas simples - Wikilivros
https://pt.wikibooks.org/wiki/Haskell/Entradas_e_sa%C3%ADdas_simples);

5. Conteúdo sobre SVG (https://maujorsvg.com.br/formas-basicas/circulo.php);
