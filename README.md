# Rick and Morty - Flutter App com MVVM + BLoC

Este projeto Flutter demonstra a arquitetura **MVVM** (Model-View-ViewModel) com uso de **BLoC** para gerenciamento de estado. A aplicação consome a API pública de Rick and Morty para exibir e pesquisar personagens. A estrutura segue princípios de organização limpa, modularidade e separação de responsabilidades.
![image](https://github.com/user-attachments/assets/7846834d-8bc3-48a1-9d19-859c5efeadfa)

---

## 🚀 Funcionalidades

- Listagem de personagens
- Pesquisa de personagens por nome
- Gerenciamento de estado com Bloc
- Integração com API REST
- Arquitetura escalável com MVVM

---

## 🧱 Arquitetura MVVM

Este projeto segue o padrão **MVVM** com separação de responsabilidades em camadas:

- **View (Camada de UI):** Exibe os dados na tela e envia ações do usuário para a ViewModel.
- **ViewModel:** Contém a lógica da tela, como requisições e controle de estados. Utilizamos o `Bloc` como ViewModel.
- **Modelos:** Representam os dados retornados da API (como `Character`).
- **Repository:** Camada intermediária entre a ViewModel e os serviços.
- **Service:** Responsável por realizar requisições HTTP.
- **Configs:** Ajuda na configuração de ambiente e criação de ViewModels.

---

## 🗂️ Estrutura de Pastas

```
lib/
│
├── configs/
│ ├── environment_helper.dart # Define ambiente da aplicação
│ └── factory_viewmodel.dart # Cria instâncias de viewmodels
│
├── core/
│ └── service/
│ └── http_service.dart # Lida com requisições HTTP
│
├── models/
│ └── character.dart # Modelo de personagem
│
├── repositories/
│ └── character_repository.dart # Repositório que centraliza acesso aos dados
│
├── views/
| ├─ characters/
│ ├── pages/ # Telas principais da funcionalidade de personagens
│ ├── viewmodel/ # Blocs, eventos e estados (lógica de negócio)
│ └── widgets/ # Componentes reutilizáveis para personagens
│
└── main.dart # Ponto de entrada do app
```

## Começo 
1. Clonando o projeto
2. Instalar dependencias com flutter pub get
3. por fim flutter run

---

![image](https://github.com/user-attachments/assets/34f0d191-411c-4257-8fc7-c3f03dc7c6d9)
![image](https://github.com/user-attachments/assets/ebbad322-d622-4296-9db3-6965b0a8c000)
![image](https://github.com/user-attachments/assets/97935b2b-e948-46a8-9ce1-62e9b478a8a8)
![image](https://github.com/user-attachments/assets/17b3e11b-9116-4708-8926-ca56635687d8)



