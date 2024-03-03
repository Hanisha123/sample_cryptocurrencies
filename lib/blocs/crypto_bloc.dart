import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/cryptocurrency.dart';
import 'crypto_event.dart';

part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  CryptoBloc() : super(CryptoInitial());

  int _currentPage = 1; // Initial page number
  final int _perPage = 20; // Number of items per page

  @override
  Stream<CryptoState> mapEventToState(
      CryptoEvent event,
      ) async* {
    if (event is FetchCryptocurrencies || event is FetchNextPageCryptocurrencies) {
      try {
        if (event is FetchCryptocurrencies) {
          _currentPage = 1; // Reset current page for initial fetch
        } else if (event is FetchNextPageCryptocurrencies) {
          _currentPage++; // Increment current page for next page fetch
        }

        yield CryptoLoading();
        final response = await http.get(Uri.parse(
            'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&page=$_currentPage&per_page=$_perPage'));
        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          final List<Cryptocurrency> cryptocurrencies =
          data.map((e) => Cryptocurrency.fromJson(e)).toList();
          yield CryptoLoaded(
            cryptocurrencies: cryptocurrencies,
            currentPage: _currentPage,
          );
        } else {
          yield CryptoLoadFailure(
            errorMessage: 'Failed to load cryptocurrencies',
          );
        }
      } catch (e) {
        yield CryptoLoadFailure(
          errorMessage: 'Failed to load cryptocurrencies: $e',
        );
      }
    }
  }
}


class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  int _currentPage = 1; // Initial page number
  final int _perPage = 20; // Number of items per page

  FavoritesBloc() : super(FavoritesInitial());

  @override
  Stream<FavoritesState> mapEventToState(FavoritesEvent event) async* {
    if (event is FetchFavorites || event is FetchNextPageFavorites) {
      try {
        if (event is FetchFavorites) {
          _currentPage = 1; // Reset current page for initial fetch
        } else if (event is FetchNextPageFavorites) {
          _currentPage++; // Increment current page for next page fetch
        }

        yield FavoritesLoading();
        final response = await http.get(Uri.parse(
            'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&page=$_currentPage&per_page=$_perPage'));
        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          final List<Cryptocurrency> favorites =
          data.map((e) => Cryptocurrency.fromJson(e)).toList();
          yield FavoritesLoaded(
            favorites: favorites,
            currentPage: _currentPage,
          );
        } else {
          yield FavoritesLoadFailure(
              errorMessage: 'Failed to load favorites');
        }
      } catch (e) {
        yield FavoritesLoadFailure(
            errorMessage: 'Failed to load favorites: $e');
      }
    }
  }
}
