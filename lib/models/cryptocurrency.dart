class Cryptocurrency {
  final String name;
  final String symbol;

  Cryptocurrency({required this.name, required this.symbol});

  factory Cryptocurrency.fromJson(Map<String, dynamic> json) {
    return Cryptocurrency(
      name: json['name'],
      symbol: json['symbol'],
    );
  }
}
