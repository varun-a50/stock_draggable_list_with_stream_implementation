import 'dart:async';

import 'package:diamondhandllp/features/wishlist/domain/usecase/add_stock_to_wishlist.dart';
import 'package:diamondhandllp/features/wishlist/domain/usecase/create_wishlist.dart';
import 'package:diamondhandllp/features/wishlist/domain/usecase/get_all_wishlist.dart';
import 'package:diamondhandllp/features/wishlist/domain/usecase/get_wishlist_by_id.dart';
import 'package:diamondhandllp/features/wishlist/domain/usecase/reorder_stock.dart';
import 'package:diamondhandllp/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:diamondhandllp/features/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final GetWishlistById getWishlishById;
  final CreateWishlist createWishlist;
  final AddStockToWishlist addStockToWishlist;
  final GetAllWishlist getAllWishlist;
  final ReorderStock reorderStock;
  StreamSubscription? _subscription;

  WishlistBloc({
    required this.getWishlishById,
    required this.createWishlist,
    required this.addStockToWishlist,
    required this.getAllWishlist,
    required this.reorderStock,
  }) : super(WishlistInit()) {
    on<GetWishlishByIdEvent>((event, emit) async {
      emit(WishlistLoading());
      await _subscription?.cancel();

      try {
        _subscription = getWishlishById(event.id).listen((event) {
          add(WishlistUpdatedEvent(event));
        });
      } catch (e) {}
    });

    on<WishlistUpdatedEvent>((event, emit) {
      emit(WishlistDataLoaded(event.marketData));
    });
    on<LoadWishlistsEvent>((event, emit) async {
      emit(WishlistLoading());

      await emit.forEach(
        getAllWishlist(),
        onData: (wishlists) => WishlistListLoaded(wishlists),
        onError: (_, __) => WishlistInit(),
      );
    });

    on<ReorderWishlistEvent>((event, emit) async {
      await reorderStock(event.id, event.oldIndex, event.newIndex);
    });
  }
}
