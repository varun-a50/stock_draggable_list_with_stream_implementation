import 'package:diamondhandllp/features/stock_dashboard/domain/entity/market_data.dart';

abstract class DashboardState {}

class StockInitial extends DashboardState {}

class StockLoading extends DashboardState {}

class StockLoaded extends DashboardState {
  final MarketData stocks;

  StockLoaded(this.stocks);
}
