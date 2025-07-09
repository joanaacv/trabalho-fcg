# RELATÓRIO

Trabalho final da disciplina INF01047 - Fundamentos de Computação Gráfica.

Prof. Eduardo Gastal, semestre de 2025/1.

Trabalho elaborado e executado pelas alunas Isis Burmeister Pericolo e Joana Alexia Campos de Vargas.

## Sobre
Um gato doméstico está a procura do local mais quentinho e confortável para tirar sua soneca. Ajude-o a encontrar o local da sala onde bate o sol da tarde! ☀️ 🐈

## Especificações
  - Malhas poligonais complexas ✅ 
  - Transformações geométricas ✅ 
  - Câmera livre e câmera look-at ✅ 
  - Testes de intersecção entre objetos virtuais 
  - Modelos de iluminação de objetos geométricos ✅ -- difuso e Blinn-Phong.
  - Instâncias de objetos ✅ -- o Gato, o quarto, os móveis, e o Sol.
  - Mapeamento de texturas UV ✅ -- o Gato, o quarto, os móveis, e o Sol.
  - Curvas de Bézier ✅ -- utilizadas para a animação do objeto Sol.
  - Animações baseadas no tempo ✅

O trabalho foi implementado na linguagem C++, utilizando OpenGL. Os objetos utilizados foram encontrados na internet, e as bibliotecas e recursos utilizados foram os referenciados pelo professor ao longo da cadeira.
O programa roda em aproximadamente 60 fps.

## Manual de utilização da aplicação

O jogo carrega usando uma câmera LookAt. As teclas W (à frente), A (à esquerda), S (para trás), e D (à direita) controlam o movimento do Gato através do quarto. O ângulo da câmera pode ser movimentado através do mouse.
Tratamento de colisões para cada objeto não foram implementadas no presente momento, apenas as Bounding Boxes existem sem os testes de intersecção.

O Sol se movimenta de maneira independente, baseado em delta-tempo, fazendo uma curva acima da cena do quarto, a fim de representar o movimento natural do sol ao longo do dia. Para este efeito foram usadas curvas de Bézier.
O objeto pode ser rotacionado em seu próprio eixo ao apertar a tecla Y, sem cessar seu movimento.

Ao pressionar as teclas X, Y ou Z em qualquer momento do programa, a matriz de rotação de ângulos de Euler é atualizada, aumentando os valores relacionados a cada variável. 
Esta informação está presente a todo momento no programa, de maneira textual no canto inferior esquerdo da tela.
Estes valores não modificam o andamento do programa nem geram mudanças visíveis na tela, exceto o vetor Y, que como indicado acima, rotaciona o Sol em seu próprio eixo.

Uma lógica de jogo não foi implementada devido à limitações temporais durante a execução deste trabalho. O Gato consegue, portanto, andar pela sala e pelo espaço tempo, com o Sol logo acima, mas sem encontrar um feixe de luz quentinho para se aninhar.
Como compensação, asseguramos de que nossos gatos na vida real tiveram diversas sonecas sob a luz do sol durante a implementação deste trabalho, e continuarão desfrutando deste conforto para além dele. ☀️ 🐈

### Modos de Câmera
Ao pressionar F, o jogo translada a câmera para o centro do Gato e habilita o modo Free Camera, onde o usuário pode
mover livremente o observador usando as teclas W, A, S, D.

![Screenshot 2025-07-08 235738](https://github.com/user-attachments/assets/0c9dc7c6-a2c4-42fd-b19c-da2ddb2ad470)

Ao apertar F novamente, já utilizando o modo Free Camera, a tela reseta para a posição inicial da câmera no modo Free Camera, ao centro do Gato.

Para retornar ao modo câmera LookAt, aperte a tecla L.

### Modelo de Interpolação de Phong e Gouraud Shading 
Por padrão, o programa utiliza Phong Shading. 

![Screenshot 2025-07-08 235827](https://github.com/user-attachments/assets/5205fbb3-e738-4278-a745-026b74b0c851)

Ao apertar a tecla M, passamos a utilizar Gouraud Shading. Para retornar ao modelo de Phong, pressione N.

![Screenshot 2025-07-08 235843](https://github.com/user-attachments/assets/09cfc253-8830-4028-9658-3fbe2b47c8b9)

### Modelos de iluminação difuso e Blinn-Phong
Após habilitar Gourard Shading (tecla M), podemos alternar entre o modelo de iluminação difusa -- ao apertar a tecla 9 -- e o modelo de iluminação Blinn-Phong -- ao apertar a tecla 0.

## Detalhes de Implementação
- A curva de Bézier que movimenta o Sol têm quatro pontos de controle e a animação do objeto é chamada a cada frame, sendo limitada a 20 segundos, para o Sol ir de um canto ao outro do quarto.
- Shading -- Phong Shading se encontra em shader_fragment.glsl; Gourard Shading se encontra em shader_vertez.glsl.
