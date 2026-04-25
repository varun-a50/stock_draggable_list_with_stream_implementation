import 'package:diamondhandllp/features/stock_dashboard/data/datasource/stock_datasource.dart';
import 'package:diamondhandllp/features/stock_dashboard/data/model/market_data_model.dart';
import 'package:diamondhandllp/features/wishlist/data/model/wishlist_model.dart';
import 'package:hive/hive.dart';

abstract class WishlistDatasource {
  Stream<MarketDataModel> getWishlistById(String id);
  Future<void> addStockToWishList(String id, String name);
  Future<void> createWishList(String id, String name);
  Stream<List<WishlistModel>> getAllWishlists();
  Future<void> reorderStock(String id, int oldIndex, int newIndex);
}

class WishlistDatasourceImpl extends WishlistDatasource {
  final Box<WishlistModel> wishlistBox;
  final StockDataSource source;
  Future<void> seedDefaultWishlists() async {
    if (!wishlistBox.containsKey("wishlist1")) {
      await wishlistBox.put(
        "wishlist1",
        WishlistModel(
          id: "wishlist1",
          name: "My Favorites",
          stockNames: ["TCS", "INFY", "HCLTECH", "ONGC", "TECHM"],
          stock: [],
        ),
      );
    }

    if (!wishlistBox.containsKey("wishlist2")) {
      await wishlistBox.put(
        "wishlist2",
        WishlistModel(
          id: "wishlist2",
          name: "Long Term",
          stockNames: ["RELIANCE", "NTPC", "TECHM", "ONGC"],
          stock: [],
        ),
      );
    }
  }

  WishlistDatasourceImpl({required this.wishlistBox, required this.source});

  @override
  Stream<MarketDataModel> getWishlistById(String id) {
    return source.getStockStream().map((marketDat) {
      final wishlist = wishlistBox.get(id);

      if (wishlist == null) {
        return MarketDataModel(indexes: [], stocks: []);
      }

      final filterStock = wishlist.stockNames.map((name) {
        return marketDat.stocks.firstWhere((s) => s.name == name);
      }).toList();

      return MarketDataModel(indexes: marketDat.indexes, stocks: filterStock);
    });
  }

  @override
  Future<void> addStockToWishList(String id, String name) async {
    final wish = wishlistBox.get(id);

    if (wish != null) {
      if (!wish.stockNames.contains(name)) {
        wish.stockNames.add(name);
      }
    }
  }

  @override
  Future<void> createWishList(String id, String name) async {
    final wishlist = WishlistModel(
      id: id,
      name: name,
      stockNames: [],
      stock: [],
    );

    await wishlistBox.put(id, wishlist);
  }

  @override
  Stream<List<WishlistModel>> getAllWishlists() async* {
    yield wishlistBox.values.toList();

    yield* wishlistBox.watch().map((_) => wishlistBox.values.toList());
  }

  @override
  Future<void> reorderStock(String id, int oldIndex, int newIndex) async {
    final wishlist = wishlistBox.get(id);
    if (wishlist == null) return;
    final item = wishlist.stockNames.removeAt(oldIndex);
    wishlist.stockNames.insert(newIndex, item);
    await wishlistBox.put(id, wishlist);
  }
}
