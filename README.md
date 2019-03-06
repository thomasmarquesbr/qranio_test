# Desafio Qranio

Projeto de aplicativo IOS nativo em relação ao desafio proposto pela Qranio.

## Features

- Login de usuário
- Cadastro de usuário
- Tela com informações do usuário
- Tela com lista de usuários já cadastrados
- Tela com informações de status sobre a API da Nasa
- Tela com lista de asteróides descobertos pela nada no período (máximo de uma semana, por limitação da API da Nasa) que é definido pelo usuário
- Tela com detalhes do asteróide selecionado
- Tela com lista de personagens da Marvel (API da Marvel)
- Opção de ver descrição dos personagens, quais comics ou eventos um personagem específico está presente

Preview do App em vídeo: preview.mov (vid)

## Dependencies

O projeto tem 4 dependências de terceiros:
1. [Firebase](https://firebase.google.com)
	- Módulos Core, Auth e Firestore como backend para login, cadastro e armazenamento de informações de usuário.
2. [Alamofire](https://github.com/Alamofire/Alamofire)
	- Facilita a criação de requisições HTTP com suporte a estruturas de dados que são retornados pelo servidor
3. [SkyFloatingLabelTextField](https://github.com/Skyscanner/SkyFloatingLabelTextField)
	- Customização de componentes UITextField com título flutuante e ícones customizados
4. [TransitionButton](https://github.com/AladinWay/TransitionButton)
    - Customização de componentes UITextField com suporte a efeitos de carregamento.

## Installing

1. Instalar o [Cocoapods](https://cocoapods.org) se for necessário.

sudo gem install cocoapods

2. Extraia o diretório e abra o terminal na raiz do projeto

3. Execute o comando para instalar as dependências presentes no Podfile na raiz do projeto

pod install

4. Abrir em uma versão recente do Xcode do arquivo "teste-qranio-thomas.xcworkspace”

5. Compilar e rodar o projeto (cmd + R)

## Plataforma de desenvolvimento usada
- IOS 11.0
- Xcode 10.1
- Swift 4
- Simulator iPhone XR 

## Autor

- **Thomás Marques Brandão Reis**  - [Email](thomas.marquesbr@gmail.com) [Github](https://github.com/thomasmbr) [Site](https://thomasmarques.com.br) [Linkedin](https://www.linkedin.com/in/thomasmarquesbr/)[Whatsapp](whatsapp://send?phone=5532991268634)

## Agradecimentos

- **Qranio Team**