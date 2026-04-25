import 'package:diamondhandllp/features/stock_dashboard/domain/entity/market_data.dart';
import 'package:diamondhandllp/features/wishlist/domain/repository/wishlist_repository.dart';

class GetWishlistById {
  final WishlistRepository repository;

  GetWishlistById({required this.repository});

  Stream<MarketData> call(String id) {
    return repository.getWishlistById(id);
  }
}
