import 'package:flutter/material.dart';
import 'package:hello/components/animated_confirm_button.dart';

class GroceryItemTile extends StatefulWidget {
  final String itemName;
  final String itemPrice;
  final String imagePath;
  final color;
  final void Function()? onPressed;

  const GroceryItemTile({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.imagePath,
    required this.color,
    required this.onPressed,
  });

  @override
  State<GroceryItemTile> createState() => _GroceryItemTileState();
}

class _GroceryItemTileState extends State<GroceryItemTile> {
  bool _isAddedToCart = false;

  void _onButtonPressed() {
    if (_isAddedToCart) return;

    widget.onPressed?.call();

    setState(() {
      _isAddedToCart = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isAddedToCart = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.color[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(widget.imagePath, height: 64),
            Text(widget.itemName),
            AnimatedConfirmButton(
              toggledChild: const Icon(
                Icons.check,
                color: Colors.white,
                key: ValueKey('icon'),
              ),
              onPressed: _onButtonPressed,
              color: widget.color[800],
              child: Text(
                '\$${widget.itemPrice}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
