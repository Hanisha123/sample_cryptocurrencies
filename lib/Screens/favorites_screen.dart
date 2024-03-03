import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/crypto_bloc.dart';
import '../blocs/crypto_event.dart';
import 'crypto_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final favoritesBloc = BlocProvider.of<FavoritesBloc>(context);
    favoritesBloc.add(FetchFavorites());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        favoritesBloc.add(FetchNextPageFavorites());
      }
    });

    return Scaffold(
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FavoritesLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.favorites.length + 1,
              itemBuilder: (context, index) {
                if (index < state.favorites.length) {
                  final cryptocurrency = state.favorites[index];
                  return Card(
                    elevation: 4, // Set the elevation for the shadow effect
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Set margins
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Set border radius for rounded corners
                    ),
                    child: InkWell(
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
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cryptocurrency.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              cryptocurrency.symbol,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
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
