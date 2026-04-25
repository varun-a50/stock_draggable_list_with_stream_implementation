import 'package:diamondhandllp/features/stock_dashboard/data/model/stock_index_model.dart';

class MarketData {
  final List<StockIndexModel> indexes;
  final List<StockIndexModel> stocks;

  MarketData({required this.indexes, required this.stocks});
}
