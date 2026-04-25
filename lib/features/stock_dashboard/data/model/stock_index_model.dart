import 'package:diamondhandllp/features/stock_dashboard/domain/entity/stock_index.dart';

class StockIndexModel extends StockIndex {
  String name;
  double value;

  StockIndexModel({required this.name, required this.value})
    : super(name: '', value: 0.0);

  factory StockIndexModel.fromJson(Map<String, dynamic> json) {
    return StockIndexModel(name: json['name'], value: json['value']);
  }

  Map<String, dynamic> toJson() => {"name": name, "value": value};
}
