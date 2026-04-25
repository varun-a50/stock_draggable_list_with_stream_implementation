import 'package:diamondhandllp/features/stock_dashboard/domain/entity/market_data.dart';

abstract class DashboardEvent {}

class StartStockStream extends DashboardEvent {}

class StockUpdated extends DashboardEvent {
  final MarketData stocks;
  StockUpdated(this.stocks);
}
