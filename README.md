# Groceries Shop App

Um aplicativo completo de compras de supermercado desenvolvido com Flutter e Node.js. Este projeto demonstra conceitos fundamentais do Flutter, incluindo gerenciamento de estado com Provider, consumo de APIs REST, arquitetura baseada em componentes e animações de UI.

## ✨ Features

### Frontend (Flutter)
- 📱 Interface moderna e responsiva
- 🛒 Navegue por uma lista de produtos disponíveis
- ➕ Adicione itens ao carrinho com animação de feedback
- 🗑️ Remova itens do carrinho
- 💰 Visualize o carrinho com cálculo automático do preço total
- 🎨 Animações suaves nos botões (transição preço → check)
- 🌈 Suporte a diferentes cores de produtos
- 💱 Formatação de moeda internacionalizada

### Backend (Node.js)
- 🚀 API REST para gerenciar produtos e carrinho
- 📦 Armazenamento em memória dos dados
- 🔄 Endpoints para CRUD de produtos
- 🛒 Gerenciamento completo do carrinho de compras

## 🏗️ Arquitetura

### Frontend
```
lib/
├── components/          # Componentes reutilizáveis
│   ├── grocery_item_tile.dart
│   └── animated_confirm_button.dart
├── model/              # Gerenciamento de estado
│   └── cart_model.dart
├── pages/              # Telas da aplicação
│   ├── intro_page.dart
│   ├── home_page.dart
│   └── cart_page.dart
├── services/           # Comunicação com APIs
│   └── api_service.dart
├── utils/              # Utilitários e helpers
│   └── color_from_string.dart
└── main.dart
```

### Backend
```
server/
├── server.js           # Servidor Express
└── package.json
```

## 🚀 Começando

### Pré-requisitos

- **Flutter SDK** (versão 3.0 ou superior)
- **Node.js** (versão 14 ou superior)
- **npm** ou **yarn**

Siga os guias oficiais:
- [Instalação do Flutter](https://docs.flutter.dev/get-started/install)
- [Instalação do Node.js](https://nodejs.org/)

### Instalação

#### 1. Clone o repositório
```bash
git clone https://github.com/luanyata/groceries-shop.git
cd groceries-shop
```

#### 2. Configure o Backend (API)
```bash
# Navegue para o diretório server (se existir)
cd server

# Instale as dependências
npm install

# Inicie o servidor
npm start
# A API estará rodando em http://localhost:3000
```

#### 3. Configure o Frontend (Flutter)
```bash
# Volte para o diretório raiz
cd ..

# Instale as dependências do Flutter
flutter pub get
```

## 🏃‍♀️ Executando a Aplicação

### 1. Inicie o servidor backend
```bash
cd server
npm start
```

### 2. Execute o aplicativo Flutter
```bash
flutter run
```

### 3. Comandos úteis durante desenvolvimento
```bash
# Hot reload (aplicar mudanças rapidamente)
r

# Hot restart (reiniciar aplicação)
R

# Quit (parar aplicação)
q
```

## 🛠️ Tecnologias e Pacotes

### Frontend (Flutter)
- [provider](https://pub.dev/packages/provider) - Gerenciamento de estado
- [http](https://pub.dev/packages/http) - Requisições HTTP
- [google_fonts](https://pub.dev/packages/google_fonts) - Fontes personalizadas
- [intl](https://pub.dev/packages/intl) - Formatação de números e moedas
- [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) - Geração de ícones

### Backend (Node.js)
- [express](https://www.npmjs.com/package/express) - Framework web
- [cors](https://www.npmjs.com/package/cors) - Configuração de CORS

## 🌐 API Endpoints

### Produtos da Loja
- `GET /api/shop-items` - Listar todos os produtos
- `GET /api/shop-items/:id` - Buscar produto específico
- `POST /api/shop-items` - Adicionar novo produto
- `PUT /api/shop-items/:id` - Atualizar produto
- `DELETE /api/shop-items/:id` - Remover produto

### Carrinho de Compras
- `GET /api/cart` - Listar itens do carrinho
- `POST /api/cart` - Adicionar item ao carrinho
- `DELETE /api/cart/:cartId` - Remover item específico
- `DELETE /api/cart` - Limpar carrinho

### Utilitários
- `GET /api/status` - Status da API

## 🧪 Testando a API

```bash
# Listar produtos
curl http://localhost:3000/api/shop-items

# Adicionar item ao carrinho
curl -X POST http://localhost:3000/api/cart \
  -H "Content-Type: application/json" \
  -d '{"itemId": 1}'

# Ver carrinho
curl http://localhost:3000/api/cart
```

## 🔧 Desenvolvimento

### Estrutura de Dados

#### Produto
```json
{
  "id": 1,
  "itemName": "Avocado",
  "itemPrice": "4.00",
  "imagePath": "lib/images/abacate.png",
  "color": "green"
}
```

#### Item do Carrinho
```json
{
  "id": 1,
  "itemName": "Avocado",
  "itemPrice": "4.00",
  "imagePath": "lib/images/abacate.png",
  "color": "green",
  "cartId": 1693847200000
}
```

## 🤝 Contribuindo

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para detalhes.
