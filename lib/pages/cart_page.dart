import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/model/cart_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'My Cart',
                  style: GoogleFonts.notoSerif(fontSize: 36),
                ),
              ),
              Expanded(
                child: cart.cartItems.isEmpty
                    ? Center(
                        child: Text(
                          'Your cart is empty',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: cart.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cart.cartItems[index];

                          return Padding(
                            padding: const EdgeInsets.all(12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                leading: Image.asset(
                                  item['imagePath'],
                                  height: 36,
                                ),
                                title: Text(item['itemName']),
                                subtitle: Text(
                                  NumberFormat.currency(
                                    locale: 'en_US',
                                    symbol: '\$',
                                  ).format(double.parse(item['itemPrice'])),
                                ),
                                trailing: IconButton(
                                  onPressed: () => cart.removeFromCart(index),
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),

              Padding(
                padding: const EdgeInsets.all(36),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Price:',
                            style: TextStyle(color: Colors.green[100]),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            NumberFormat.currency(
                              locale: 'en_US',
                              symbol: '\$',
                            ).format(cart.getTotalPrice()),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green.shade100),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Text(
                              'Pay Now',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
