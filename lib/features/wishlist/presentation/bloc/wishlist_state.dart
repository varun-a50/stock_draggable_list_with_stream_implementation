import 'package:diamondhandllp/features/stock_dashboard/domain/entity/market_data.dart';
import 'package:diamondhandllp/features/wishlist/domain/entity/wishlist.dart';

abstract class WishlistState {}

class WishlistInit extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistListLoaded extends WishlistState {
  final List<Wishlist> wishlists;

  WishlistListLoaded(this.wishlists);
}

class WishlistDataLoaded extends WishlistState {
  final MarketData marketData;

  WishlistDataLoaded(this.marketData);
}
