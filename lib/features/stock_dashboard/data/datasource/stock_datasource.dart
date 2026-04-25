import 'package:diamondhandllp/features/stock_dashboard/data/model/market_data_model.dart';
import 'package:diamondhandllp/features/stock_dashboard/data/model/stock_index_model.dart';
import 'dart:async';
import 'dart:math';

abstract class StockDataSource {
  Stream<MarketDataModel> getStockStream();
}

class StockDataSourceImpl implements StockDataSource {
  final _controller = StreamController<MarketDataModel>.broadcast();
  final Random _random = Random();

  List<StockIndexModel> indexes = [
    StockIndexModel(name: "NSE", value: 22000),
    StockIndexModel(name: "BSE", value: 73000),
  ];

  List<StockIndexModel> stocks = [
    StockIndexModel(name: "TCS", value: 3800),
    StockIndexModel(name: "INFY", value: 1500),
    StockIndexModel(name: "RELIANCE", value: 2900),
    StockIndexModel(name: "WIPRO", value: 520),
    StockIndexModel(name: "HCLTECH", value: 1450),
    StockIndexModel(name: "TECHM", value: 1200),
    StockIndexModel(name: "LTIM", value: 5400),
    StockIndexModel(name: "ONGC", value: 280),
    StockIndexModel(name: "NTPC", value: 360),
    StockIndexModel(name: "POWERGRID", value: 320),
    StockIndexModel(name: "ADANIGREEN", value: 1850),
  ];

  Timer? _timer;

  @override
  Stream<MarketDataModel> getStockStream() {
    _startStreaming();
    return _controller.stream;
  }

  void _startStreaming() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(milliseconds: 800), (_) {
      _updateList(indexes);
      _updateList(stocks);

      _controller.add(
        MarketDataModel(indexes: List.from(indexes), stocks: List.from(stocks)),
      );
    });
  }

  void _updateList(List<StockIndexModel> list) {
    for (var item in list) {
      double change = (_random.nextInt(10) + 1).toDouble();

      if (_random.nextBool()) {
        item.value += change;
      } else {
        item.value -= change;
      }
    }
  }
}
