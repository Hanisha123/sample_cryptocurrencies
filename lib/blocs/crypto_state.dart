part of 'crypto_bloc.dart';

@immutable
abstract class CryptoState {}

class CryptoInitial extends CryptoState {}

class CryptoLoading extends CryptoState {}

class CryptoLoaded extends CryptoState {
  final List<Cryptocurrency> cryptocurrencies;
  final int currentPage;

  CryptoLoaded({required this.cryptocurrencies, required this.currentPage});
}

class CryptoLoadFailure extends CryptoState {
  final String errorMessage;

  CryptoLoadFailure({required this.errorMessage});
}

@immutable
abstract class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Cryptocurrency> favorites;
  final int currentPage;

  FavoritesLoaded({required this.favorites, required this.currentPage});
}

class FavoritesLoadFailure extends FavoritesState {
  final String errorMessage;

  FavoritesLoadFailure({required this.errorMessage});
}