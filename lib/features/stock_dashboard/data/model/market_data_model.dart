import 'package:diamondhandllp/features/stock_dashboard/data/model/stock_index_model.dart';
import 'package:diamondhandllp/features/stock_dashboard/domain/entity/market_data.dart';

class MarketDataModel extends MarketData {
  final List<StockIndexModel> indexes;
  final List<StockIndexModel> stocks;

  MarketDataModel({required this.indexes, required this.stocks})
    : super(indexes: [], stocks: []);
}
