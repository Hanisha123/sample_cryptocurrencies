import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/crypto_bloc.dart';
import 'screens/current_cryptocurrencies_screen.dart';
import 'screens/favorites_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Crypto App'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Current Cryptocurrencies'),
              Tab(text: 'Favorites'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocProvider(
              create: (context) => CryptoBloc(),
              child: CurrentCryptocurrenciesScreen(),
            ),
            BlocProvider(
              create: (context) => FavoritesBloc(), // Provide FavoritesBloc
              child: FavoritesScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
