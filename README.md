# Githubparty
App de testes que consome a API do github, exibe os mais famosos repos de Swift em ordem decrescente, detalha pull requests e abre em uma WebView detalhes sobre os pull requests.

## Solução adotada
<img src="https://github.com/user-attachments/assets/d56f952d-3361-4bf9-90db-99cb31c5aa55" width="80%">
<br>Acima, está o diagrama que ilustra a estruturação do consumo e o fluxo do serviço.

<br><img src="https://github.com/user-attachments/assets/cc751bb0-9d2b-4d95-9e47-ab73f6a5c6d9" width="30%">
<img src="https://github.com/user-attachments/assets/ed196694-be4c-4eed-9d77-7e44e90ad218" width="30%">
<img src="https://github.com/user-attachments/assets/b4c21c2f-ed2a-4182-93ff-ed9b0610cdde" width="30%">
<img src="https://github.com/user-attachments/assets/461e7e61-f52b-497d-a5f8-76e6a7f6d963" width="30%">

## Libs utilizadas
Utilizei o Kingfisher https://github.com/onevcat/Kingfisher via SPM, já pensando em otimização no consumo de imagens, uma vez que o<br>
objetivo do Kingfisher é fazer cache de imagens, assim, batemos no serviço para o consumo de imagens apenas uma vez e o resto<br>
o Kingfisher é quem vai atras de buscar as imagens que ficaram em cache, numa próxima vez que o app for reaberto, as imagens serão<br>
cacheadas novamente.

## Arquitetura
Para o projeto, optei por seguir com o Clean Swift utilizando VIP, já pensando em boas práticas como Desacoplamento, Escalabilidade e Testabilidade.
O motivo pelo qual optei seguir esse padrao arquitetural foi justamente por conta da modularidade que ele nos permite onde cada camada é bem definida<br>
e tem sua responsabilidade, assim, caso precisemos modificar algo no app, precisaremos mexer em algo bem pontual, nao comprometendo o restante da aplicaçao.


## Escolhas feitas
- Foram aplicados conceitos de injeção e inversão de dependência com o objetivo de promover o desacoplamento e garantir a testabilidade do aplicativo.
Além disso, utilizei o padrão Factory para criar os ViewControllers e resolver suas dependências de forma centralizada. Para gerenciar a navegação, 
apliquei o padrão Coordinator, delegando essa responsabilidade para fora das ViewControllers e mantendo-as mais coesas e focadas em suas funções.

- Para tornar o app modular, além de ter optado por usar o Clean Architecture, pensei em criar módulo utilizando SPM, onde criei os módulos, onde cada módulo permite seus testes separados:<br>
   - Data
   - DataInterface
   - Domain
   - DomainInterface
   - TestUtils
   - Utils
   - HomeModule

- Para testar o app optei por utilizar XCTest e apliquei conceitos como: Spy, Stub e Fixture.
- Criei um mini Design System onde centralizei: Spacing, Size, CommonNames que seriam necessários no App.
- Criei Constants para evitar valores espalhados pelo app.

* Observe que não levei 100% a risca a arquitetura que segui, onde na teoria teriamos: NetworkManager > Service > *DataSource* > Repository > UseCase
* optei por nao incluir o DataSource e injetar diretamente o Service no Repository visto que estariamos apenas passando os dados para frente sem necessidade de alguma outra lógica.
* Vale ressaltar que essa flexibidade se dá por conta das necessidades do momento, sendo perfeitamente possível de mudar isso mais para frente caso necessário.

## Instruções para executar o projeto
Como utilizei apenas SPM, basta abrir o projeto e executar normalmente.
