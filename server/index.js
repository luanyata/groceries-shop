const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Dados em memória (baseados no seu CartModel)
let shopItems = [
  {
    id: 1,
    itemName: "Avocado",
    itemPrice: "4.00",
    imagePath: "lib/images/abacate.png",
    color: "green"
  },
  {
    id: 2,
    itemName: "Banana",
    itemPrice: "2.00",
    imagePath: "lib/images/banana.png",
    color: "yellow"
  },
  {
    id: 3,
    itemName: "Strawberry",
    itemPrice: "4.50",
    imagePath: "lib/images/morango.png",
    color: "red"
  },
  {
    id: 4,
    itemName: "Grapes",
    itemPrice: "3.00",
    imagePath: "lib/images/uva.png",
    color: "purple"
  },
  {
    id: 5,
    itemName: "Watermelon",
    itemPrice: "5.00",
    imagePath: "lib/images/melancia.png",
    color: "green"
  }
];

let cartItems = [];
let nextId = 6; // Para novos itens

// ROTAS PARA SHOP ITEMS

// GET - Listar todos os itens da loja
app.get('/api/shop-items', (req, res) => {
  res.json({
    success: true,
    data: shopItems,
    total: shopItems.length
  });
});

// GET - Buscar item específico por ID
app.get('/api/shop-items/:id', (req, res) => {
  const id = parseInt(req.params.id);
  const item = shopItems.find(item => item.id === id);

  if (!item) {
    return res.status(404).json({
      success: false,
      message: 'Item not found'
    });
  }

  res.json({
    success: true,
    data: item
  });
});

// POST - Adicionar novo item à loja
app.post('/api/shop-items', (req, res) => {
  const { itemName, itemPrice, imagePath, color } = req.body;

  // Validação básica
  if (!itemName || !itemPrice) {
    return res.status(400).json({
      success: false,
      message: 'itemName and itemPrice are required'
    });
  }

  const newItem = {
    id: nextId++,
    itemName,
    itemPrice,
    imagePath: imagePath || '',
    color: color || 'green'
  };

  shopItems.push(newItem);

  res.status(201).json({
    success: true,
    message: 'Item created successfully',
    data: newItem
  });
});

// PUT - Atualizar item existente
app.put('/api/shop-items/:id', (req, res) => {
  const id = parseInt(req.params.id);
  const itemIndex = shopItems.findIndex(item => item.id === id);

  if (itemIndex === -1) {
    return res.status(404).json({
      success: false,
      message: 'Item not found'
    });
  }

  const { itemName, itemPrice, imagePath, color } = req.body;

  shopItems[itemIndex] = {
    ...shopItems[itemIndex],
    ...(itemName && { itemName }),
    ...(itemPrice && { itemPrice }),
    ...(imagePath && { imagePath }),
    ...(color && { color })
  };

  res.json({
    success: true,
    message: 'Item updated successfully',
    data: shopItems[itemIndex]
  });
});

// DELETE - Remover item da loja
app.delete('/api/shop-items/:id', (req, res) => {
  const id = parseInt(req.params.id);
  const itemIndex = shopItems.findIndex(item => item.id === id);

  if (itemIndex === -1) {
    return res.status(404).json({
      success: false,
      message: 'Item not found'
    });
  }

  const deletedItem = shopItems.splice(itemIndex, 1)[0];

  res.json({
    success: true,
    message: 'Item deleted successfully',
    data: deletedItem
  });
});

// ROTAS PARA CARRINHO

// GET - Listar itens do carrinho
app.get('/api/cart', (req, res) => {
  const total = cartItems.reduce((sum, item) => sum + parseFloat(item.itemPrice), 0);

  res.json({
    success: true,
    data: cartItems,
    total: cartItems.length,
    totalPrice: total.toFixed(2)
  });
});

// POST - Adicionar item ao carrinho
app.post('/api/cart', (req, res) => {
  const { itemId } = req.body;

  if (!itemId) {
    return res.status(400).json({
      success: false,
      message: 'itemId is required'
    });
  }

  const shopItem = shopItems.find(item => item.id === itemId);

  if (!shopItem) {
    return res.status(404).json({
      success: false,
      message: 'Shop item not found'
    });
  }

  // Adiciona uma cópia do item ao carrinho
  const cartItem = {
    ...shopItem,
    cartId: Date.now() // ID único para o item no carrinho
  };

  cartItems.push(cartItem);

  res.status(201).json({
    success: true,
    message: 'Item added to cart',
    data: cartItem
  });
});

// DELETE - Remover item específico do carrinho
app.delete('/api/cart/:cartId', (req, res) => {
  const cartId = parseInt(req.params.cartId);
  const itemIndex = cartItems.findIndex(item => item.cartId === cartId);

  if (itemIndex === -1) {
    return res.status(404).json({
      success: false,
      message: 'Cart item not found'
    });
  }

  const deletedItem = cartItems.splice(itemIndex, 1)[0];

  res.json({
    success: true,
    message: 'Item removed from cart',
    data: deletedItem
  });
});

// DELETE - Limpar carrinho
app.delete('/api/cart', (req, res) => {
  const itemCount = cartItems.length;
  cartItems.length = 0; // Limpa o array

  res.json({
    success: true,
    message: `Cart cleared. ${itemCount} items removed.`
  });
});

// Rota de status da API
app.get('/api/status', (req, res) => {
  res.json({
    success: true,
    message: 'Groceries API is running',
    timestamp: new Date().toISOString(),
    endpoints: {
      shopItems: '/api/shop-items',
      cart: '/api/cart'
    }
  });
});

// Middleware de erro 404
app.use('*', (req, res) => {
  res.status(404).json({
    success: false,
    message: 'Route not found'
  });
});

// Iniciar servidor
app.listen(PORT, () => {
  console.log(`🚀 Groceries API running on http://localhost:${PORT}`);
  console.log(`📋 Status: http://localhost:${PORT}/api/status`);
});