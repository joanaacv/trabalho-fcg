# RELATÓRIO

Trabalho final da disciplina INF01047 - Fundamentos de Computação Gráfica  
Prof. Eduardo Gastal, semestre de 2025/1

Trabalho elaborado e executado pelas alunas Isis Burmeister Pericolo e Joana Alexia Campos de Vargas.

## Sobre
Um gato doméstico está à procura do local mais quentinho e confortável para tirar sua soneca. Ajude-o a encontrar o local da sala onde bate o sol da tarde!
 ☀️ 🐈


---

## Contribuições de cada membro

- **Isis Burmeister Pericolo:** Implementação da lógica de movimentação do gato, integração das malhas poligonais, desenvolvimento dos testes de colisão e parte da documentação.
- **Joana Alexia Campos de Vargas:** Implementação dos modelos de iluminação, texturização dos objetos, desenvolvimento da câmera livre/look-at e animações, além da organização do código.

---

## Uso de ferramentas de IA

A dupla fez uso do GitHub Copilot (ChatGPT 4.1) para auxílio durante o desenvolvimento. As ferramentas foram utilizadas principalmente para sugestões de código em C++/OpenGL, esclarecimento de dúvidas sobre shaders, rastreio de erros na execução, exemplos de implementação de curvas de Bézier, e formatação da documentação. Consideramos as ferramentas úteis para acelerar a escrita de código repetitivo e para consulta rápida de sintaxe, mas em tópicos mais avançados de computação gráfica (como integração de múltiplos shaders e lógica de colisão), as respostas nem sempre foram precisas ou adaptadas ao contexto do nosso projeto, exigindo revisão manual e ajustes.


## Especificações e conceitos aplicados

  - Malhas poligonais complexas ✅ 
  - Transformações geométricas ✅ 
  - Câmera livre e câmera look-at ✅ 
  - Testes de intersecção entre objetos virtuais ❌
  - Modelos de iluminação de objetos geométricos ✅ -- difuso e Blinn-Phong.
  - Instâncias de objetos ✅ -- o Gato, o quarto, os móveis, e o Sol.
  - Mapeamento de texturas UV ✅ -- o Gato, o quarto, os móveis, e o Sol.
  - Curvas de Bézier ✅ -- utilizadas para a animação do objeto Sol.
  - Animações baseadas no tempo ✅

O trabalho foi implementado na linguagem C++, utilizando OpenGL. Os objetos utilizados foram encontrados na internet, e as bibliotecas e recursos utilizados foram os referenciados pelo professor ao longo da cadeira.
O programa roda em aproximadamente 60 fps.

## Manual de utilização da aplicação

O jogo carrega usando uma câmera LookAt. As teclas W (à frente), A (à esquerda), S (para trás), e D (à direita) controlam o movimento do Gato através da sala. O ângulo da câmera pode ser movimentado através do mouse.
Tratamento de colisões para cada objeto não foram implementadas no presente momento, apenas as Bounding Boxes existem, sem os testes de intersecção.

O Sol se movimenta de maneira independente, baseado em delta-tempo, fazendo uma curva acima da cena da sala, a fim de representar o movimento natural do sol ao longo do dia. Para este efeito foram usadas curvas de Bézier.
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

### Modelo de Interpolação de Blinn-Phong e Gouraud Shading 
Por padrão, o programa utiliza Blinn-Phong Shading. 

![Screenshot 2025-07-08 235827](https://github.com/user-attachments/assets/5205fbb3-e738-4278-a745-026b74b0c851)

Ao apertar a tecla M, passamos a utilizar Gouraud Shading. Para retornar ao modelo de Phong, pressione N.

![Screenshot 2025-07-08 235843](https://github.com/user-attachments/assets/09cfc253-8830-4028-9658-3fbe2b47c8b9)

### Modelos de iluminação difuso e Blinn-Phong
Após habilitar Gourard Shading (tecla M), podemos alternar entre os modelos de iluminação:

- Difusa -- ao apertar a tecla 9
  
![Screenshot 2025-07-09 194142](https://github.com/user-attachments/assets/ada00356-386b-4679-8ed6-66eeb25d4a23)


- Blinn-Phong -- ao apertar a tecla 0
  
![Screenshot 2025-07-09 194200](https://github.com/user-attachments/assets/547494ab-54ed-426d-98ec-ffd181cde8f8)


## Detalhes de Implementação
- A curva de Bézier que movimenta o Sol têm quatro pontos de controle e a animação do objeto é chamada a cada frame, sendo limitada a 20 segundos, para o Sol ir de um canto ao outro do quarto.
- Shading -- Phong Shading se encontra em shader_fragment.glsl; Gourard Shading se encontra em shader_vertez.glsl.


## Como compilar e executar

### Linux

1. Instale as dependências necessárias (GLFW, OpenGL, etc). Em Ubuntu:
   ```sh
   sudo apt-get install build-essential libglfw3-dev libglm-dev libglew-dev libx11-dev libxi-dev libxrandr-dev libxinerama-dev libxcursor-dev libxxf86vm-dev
   ```
2. Compile usando o Makefile:
   ```sh
   make
   ```
3. Execute:
   ```sh
   make run
   ```

### macOS

1. Instale as dependências via Homebrew:
   ```sh
   brew install glfw glm
   ```
2. Compile usando o Makefile específico:
   ```sh
   make -f Makefile.macOS
   ```
3. Execute:
   ```sh
   make -f Makefile.macOS run
   ```

### Windows

- Recomenda-se o uso do Code::Blocks ou VSCode com MinGW. Veja instruções detalhadas no arquivo `informacoesDeCompilacao.txt`.
