import 'package:diamondhandllp/features/stock_dashboard/domain/entity/market_data.dart';

abstract class StockRepository {
  Stream<MarketData> getStockStream();
}
