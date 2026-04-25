import 'package:diamondhandllp/features/stock_dashboard/data/datasource/stock_datasource.dart';
import 'package:diamondhandllp/features/stock_dashboard/domain/entity/market_data.dart';
import 'package:diamondhandllp/features/stock_dashboard/domain/repository/stock_repository.dart';

class StockRepositoryImpl implements StockRepository {
  final StockDataSource dataSource;

  StockRepositoryImpl(this.dataSource);

  @override
  Stream<MarketData> getStockStream() {
    return dataSource.getStockStream();
  }
}
