import 'package:diamondhandllp/features/stock_dashboard/domain/entity/market_data.dart';
import 'package:diamondhandllp/features/wishlist/domain/entity/wishlist.dart';

abstract class WishlistRepository {
  Stream<MarketData> getWishlistById(String id);
  Stream<List<Wishlist>> getAllWishlists();
  Future<void> addStockToWishList(String id, String name);
  Future<void> createWishList(String id, String name);
  Future<void> reorderStock(String id, int oldIndex, int newIndex);
}
