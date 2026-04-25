import 'package:diamondhandllp/features/stock_dashboard/domain/entity/market_data.dart';
import 'package:diamondhandllp/features/stock_dashboard/domain/repository/stock_repository.dart';

class GetStockStream {
  final StockRepository repository;

  GetStockStream(this.repository);

  Stream<MarketData> call() {
    return repository.getStockStream();
  }
}
