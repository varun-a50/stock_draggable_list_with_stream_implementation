import 'package:diamondhandllp/features/stock_dashboard/domain/entity/stock_index.dart';
import 'package:diamondhandllp/features/wishlist/domain/entity/wishlist.dart';
import 'package:hive/hive.dart';

part 'wishlist_model.g.dart';

@HiveType(typeId: 0)
class WishlistModel extends Wishlist {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  List<String> stockNames;
  @HiveField(3)
  List<StockIndex> stock;

  WishlistModel({
    required this.id,
    required this.name,
    required this.stockNames,
    required this.stock,
  }) : super(id: '', name: '', stockNames: [], stock: []);
}
