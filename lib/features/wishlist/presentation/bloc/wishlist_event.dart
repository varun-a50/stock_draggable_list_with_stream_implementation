import 'package:diamondhandllp/features/stock_dashboard/domain/entity/market_data.dart';

abstract class WishlistEvent {}

class LoadWishlistsEvent extends WishlistEvent {}

class GetWishlishByIdEvent extends WishlistEvent {
  String id;

  GetWishlishByIdEvent({required this.id});
}

class CreateWishlistEvent extends WishlistEvent {
  String id;
  String name;

  CreateWishlistEvent({required this.id, required this.name});
}

class AddStockToWishlistEvent extends WishlistEvent {
  String id;
  String name;

  AddStockToWishlistEvent({required this.id, required this.name});
}

class WishlistUpdatedEvent extends WishlistEvent {
  final MarketData marketData;

  WishlistUpdatedEvent(this.marketData);
}

class ReorderWishlistEvent extends WishlistEvent {
  final String id;
  final int oldIndex;
  final int newIndex;

  ReorderWishlistEvent({
    required this.id,
    required this.oldIndex,
    required this.newIndex,
  });
}
