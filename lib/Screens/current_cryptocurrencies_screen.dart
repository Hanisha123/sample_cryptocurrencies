import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/crypto_bloc.dart';
import '../blocs/crypto_event.dart';
import '../models/cryptocurrency.dart';
import 'crypto_detail_screen.dart';

class CurrentCryptocurrenciesScreen extends StatefulWidget {
  @override
  _CurrentCryptocurrenciesScreenState createState() =>
      _CurrentCryptocurrenciesScreenState();
}

class _CurrentCryptocurrenciesScreenState
    extends State<CurrentCryptocurrenciesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final cryptoBloc = BlocProvider.of<CryptoBloc>(context);
    cryptoBloc.add(FetchCryptocurrencies());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        cryptoBloc.add(FetchNextPageCryptocurrencies());
      }
    });

    return Scaffold(
      body: BlocBuilder<CryptoBloc, CryptoState>(
        builder: (context, state) {
          if (state is CryptoLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CryptoLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.cryptocurrencies.length + 1,
              itemBuilder: (context, index) {
                if (index < state.cryptocurrencies.length) {
                  final cryptocurrency = state.cryptocurrencies[index];
                  return Card(
                    elevation: 4, // Adjust the elevation for the shadow effect
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Adjust the margins as needed
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Add border radius for rounded corners
                    ),
                    child: ListTile(
                      title: Text(cryptocurrency.name),
                      subtitle: Text(cryptocurrency.symbol),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CryptoDetailScreen(
                              name: cryptocurrency.name,
                              symbol: cryptocurrency.symbol,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          } else if (state is CryptoLoadFailure) {
            return Center(child: Text(state.errorMessage));
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
