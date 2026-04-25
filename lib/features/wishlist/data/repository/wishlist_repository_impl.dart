import 'package:diamondhandllp/features/stock_dashboard/domain/entity/market_data.dart';
import 'package:diamondhandllp/features/wishlist/data/datasource/wishlist_datasource.dart';
import 'package:diamondhandllp/features/wishlist/domain/entity/wishlist.dart';
import 'package:diamondhandllp/features/wishlist/domain/repository/wishlist_repository.dart';

class WishlistRepositoryImpl extends WishlistRepository {
  final WishlistDatasource datasource;

  WishlistRepositoryImpl({required this.datasource});

  @override
  Future<void> addStockToWishList(String id, String name) async {
    await datasource.addStockToWishList(id, name);
  }

  @override
  Future<void> createWishList(String id, String name) async {
    await datasource.addStockToWishList(id, name);
  }

  @override
  Stream<MarketData> getWishlistById(String id) {
    return datasource.getWishlistById(id);
  }

  @override
  Stream<List<Wishlist>> getAllWishlists() {
    return datasource.getAllWishlists();
  }

  @override
  Future<void> reorderStock(String id, int oldIndex, int newIndex) async {
    await datasource.reorderStock(id, oldIndex, newIndex);
  }
}
