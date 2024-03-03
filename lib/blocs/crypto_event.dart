import 'package:meta/meta.dart';

@immutable
abstract class CryptoEvent {}

class FetchCryptocurrencies extends CryptoEvent {}

class FetchNextPageCryptocurrencies extends CryptoEvent {}

@immutable
abstract class FavoritesEvent {}

class FetchFavorites extends FavoritesEvent {}

class FetchNextPageFavorites extends FavoritesEvent {}