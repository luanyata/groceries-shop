import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/components/grocery_item_tile.dart';
import 'package:hello/model/cart_model.dart';
import 'package:hello/pages/cart_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CartPage()),
        ),
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.shopping_bag, color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Good morning
            const SizedBox(height: 48),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text('Good morning'),
            ),

            const SizedBox(height: 4),
            // Lets Order fresh Items for you
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Lets Order fresh Items for you',
                style: GoogleFonts.notoSerif(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            //  Divider
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Divider(),
            ),

            const SizedBox(height: 24),
            // Fresh Items + grind
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Fresh Items',
                style: GoogleFonts.notoSerif(fontSize: 16),
              ),
            ),

            Expanded(
              child: Consumer<CartModel>(
                builder: (context, value, child) => GridView.builder(
                  itemCount: value.shopItems.length,
                  padding: const EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.3,
                  ),
                  itemBuilder: (context, index) => GroceryItemTile(
                    itemName: value.shopItems[index][0],
                    itemPrice: value.shopItems[index][1],
                    imagePath: value.shopItems[index][2],
                    color: value.shopItems[index][3],
                    onPressed: () {
                      Provider.of<CartModel>(
                        context,
                        listen: false,
                      ).addToCart(index);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
