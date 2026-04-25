import 'package:flutter/material.dart';
import 'package:diamondhandllp/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:diamondhandllp/features/wishlist/presentation/bloc/wishlist_event.dart';
import 'package:diamondhandllp/features/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListMain extends StatefulWidget {
  final String wishlistId;
  const WishListMain({super.key, required this.wishlistId});

  @override
  State<WishListMain> createState() => _WishListMainState();
}

class _WishListMainState extends State<WishListMain> {
  List<String> _localStockNames = [];
  @override
  void initState() {
    super.initState();
    context.read<WishlistBloc>().add(
      GetWishlishByIdEvent(id: widget.wishlistId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistBloc, WishlistState>(
      buildWhen: (previous, current) => current is WishlistDataLoaded,
      builder: (context, state) {
        if (state is WishlistDataLoaded) {
          _localStockNames = state.marketData.stocks
              .map((s) => s.name)
              .toList();

          final stocks = state.marketData.stocks;

          return ListView.builder(
            itemCount: _localStockNames.length,
            itemBuilder: (context, index) {
              final name = _localStockNames[index]; // ✅ get name by index
              final stock = stocks.firstWhere(
                (s) => s.name == name,
                orElse: () => stocks.first,
              );
              return ListTile(
                key: ValueKey(name),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
                title: Text(
                  stock.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Color.fromARGB(255, 26, 26, 46),
                  ),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    stock.value.toStringAsFixed(2),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color.fromARGB(255, 92, 107, 192),
                    ),
                  ),
                ),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
