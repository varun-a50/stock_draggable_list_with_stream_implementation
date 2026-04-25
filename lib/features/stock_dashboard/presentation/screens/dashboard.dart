import 'package:diamondhandllp/features/stock_dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:diamondhandllp/features/stock_dashboard/presentation/bloc/dashboard_state.dart';
import 'package:diamondhandllp/features/stock_dashboard/presentation/widgets/top_index_widget.dart';
import 'package:diamondhandllp/features/wishlist/presentation/bloc/wishlist_bloc.dart';
import 'package:diamondhandllp/features/wishlist/presentation/bloc/wishlist_state.dart';
import 'package:diamondhandllp/features/wishlist/presentation/screens/wish_list_main.dart';
import 'package:diamondhandllp/features/wishlist/presentation/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state is StockLoaded) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: const Color(0xFFF6F7FB),
              body: Column(
                children: [
                  TopIndexWidget(
                    firstLabel: state.stocks.indexes[0].name,
                    firstValue: state.stocks.indexes[0].value,
                    secondLable: state.stocks.indexes[1].name,
                    secondValue: state.stocks.indexes[1].value,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                    child: TextField(
                      controller: _search,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Search for instruments",
                        hintStyle: const TextStyle(
                          color: Color(0xFFBDBDBD),
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFFBDBDBD),
                          size: 20,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF5C6BC0),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<WishlistBloc, WishlistState>(
                      buildWhen: (previous, current) =>
                          current is WishlistListLoaded,
                      builder: (context, state) {
                        if (state is WishlistListLoaded) {
                          final wishlists = state.wishlists;

                          return DefaultTabController(
                            length: wishlists.length,
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.white,
                                  child: TabBar(
                                    isScrollable: true,
                                    indicatorColor: const Color(0xFF5C6BC0),
                                    indicatorWeight: 3,
                                    labelColor: const Color(0xFF5C6BC0),
                                    unselectedLabelColor: const Color(
                                      0xFF9E9E9E,
                                    ),
                                    labelStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                    unselectedLabelStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                    tabs: wishlists
                                        .map(
                                          (w) => GestureDetector(
                                            onDoubleTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    WishlistScreenEdit(
                                                      wishlistName: w.name,
                                                      stockNames: w.stockNames,
                                                      wishlistId: w.id,
                                                    ),
                                              ),
                                            ),
                                            child: Tab(text: w.name),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    children: wishlists.map((wishlist) {
                                      return WishListMain(
                                        wishlistId: wishlist.id,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container(color: const Color(0xFFF6F7FB));
      },
    );
  }
}
