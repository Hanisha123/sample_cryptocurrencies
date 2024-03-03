import 'package:flutter/material.dart';

class CryptoDetailScreen extends StatelessWidget {
  final String name;
  final String symbol;

  CryptoDetailScreen({required this.name, required this.symbol});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: $name'),
            Text('Symbol: $symbol'),
            // Add more details if needed
          ],
        ),
      ),
    );
  }
}
