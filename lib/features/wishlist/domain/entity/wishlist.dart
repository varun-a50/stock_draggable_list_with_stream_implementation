import 'package:diamondhandllp/features/stock_dashboard/domain/entity/stock_index.dart';

class Wishlist {
  final String id;
  final String name;
  final List<String> stockNames;
  final List<StockIndex> stock;

  Wishlist({
    required this.id,
    required this.name,
    required this.stockNames,
    required this.stock,
  });
}
