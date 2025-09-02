import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/pages/home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // logo
          Padding(
            padding: const EdgeInsets.only(
              left: 80.0,
              right: 80.0,
              bottom: 40.0,
              top: 160.0,
            ),
            child: Image.asset('lib/images/abacate.png'),
          ),

          // We Deliver groceries at your doorstep
          Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              'We Deliver groceries at your doorstep',
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSerif(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 24.0),

          // fresh items every day
          Text(
            'Fresh items everyday',
            style: TextStyle(color: Colors.grey[600]),
          ),

          const Spacer(),

          // Get started button
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(24),
              child: const Text(
                'Get Started',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
