import 'package:final_project_restaurant_app/data/api/restaurant_api.dart';
import 'package:final_project_restaurant_app/provider/search_restaurant_provider.dart';
import 'package:final_project_restaurant_app/widgets/card_search_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchRestaurant = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("search"),
      ),
      body: Column(
        children: [
          ChangeNotifierProvider(
            create: (context) => SearchRestaurantProvider(
              restaurantApi: RestaurantApi(),
            ),
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Consumer<SearchRestaurantProvider>(
                      builder: (context, search, _) {
                        return TextField(
                          decoration: const InputDecoration(
                            hintText: "Restaurant",
                            hintStyle: TextStyle(color: Colors.black),
                            contentPadding: EdgeInsets.only(left: 15),
                            fillColor: Colors.white,
                            focusColor: Colors.white,
                            hoverColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                            ),
                          ),
                          onChanged: (String value) {
                            searchRestaurant = value;
                            search.searchInput(value);
                            // state.searchInput(value);
                          },
                        );
                      },
                    ),
                  ),
                  Consumer<SearchRestaurantProvider>(
                    builder: (context, state, _) {
                      if (state.state == ResultState.loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state.state == ResultState.hasData) {
                        final dataSearchRestaurant =
                            state.resultSearch.restaurants;
                        final isHideSearchScreen = state.isHideSearch;
                        return isHideSearchScreen == false
                            ? const Expanded(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.search,
                                        size: 100,
                                      ),
                                      Text("Finding restaurant for you "),
                                      Text("please wait.")
                                    ],
                                  ),
                                ),
                              )
                            : Expanded(
                                child: RefreshIndicator(
                                  onRefresh: () {
                                    return state.restaurantApi
                                        .getSearchRestaurant(searchRestaurant);
                                  },
                                  child: ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    itemCount: dataSearchRestaurant.length,
                                    itemBuilder: (context, index) {
                                      var data =
                                          state.resultSearch.restaurants[index];
                                      return CardSearchWidgets(
                                        dataSearch: data,
                                      );
                                    },
                                  ),
                                ),
                              );
                      } else if (state.state == ResultState.noData) {
                        return Expanded(
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      } else if (state.state == ResultState.error) {
                        return Expanded(
                          child: Center(
                            child: Text(state.message),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
