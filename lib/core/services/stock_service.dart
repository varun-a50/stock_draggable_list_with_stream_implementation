import 'dart:async';
import 'dart:math';

import 'package:diamondhandllp/features/stock_dashboard/data/model/stock_index_model.dart';

class StockService {
  final _controller = StreamController<List<Map<String, dynamic>>>();
  final Random _random = Random();

  List<StockIndexModel> indexes = [
    StockIndexModel(name: "NSE", value: 22000),
    StockIndexModel(name: "BSE", value: 73000),
  ];

  Stream<List<Map<String, dynamic>>> get stream => _controller.stream;

  void startStreaming() {
    Timer.periodic(Duration(seconds: 2), (_) {
      for (var index in indexes) {
        double change = (_random.nextInt(10) + 1).toDouble();

        // randomly + or -
        if (_random.nextBool()) {
          index.value += change;
        } else {
          index.value -= change;
        }
      }

      _controller.add(indexes.map((e) => e.toJson()).toList());
    });
  }

  void dispose() {
    _controller.close();
  }
}
