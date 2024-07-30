import 'package:final_project_restaurant_app/page/search/search_page.dart';
import 'package:final_project_restaurant_app/provider/list_restaurant_provider.dart';
import 'package:final_project_restaurant_app/widgets/card_restaurant_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListRestaurantPage extends StatelessWidget {
  const ListRestaurantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.search,
              size: 40,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 15, bottom: 15),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Restaurant",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .apply(color: Colors.amber)),
                const Text(
                  "Recommendation restaurant for you!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Consumer<ListRestaurantProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state.state == ResultState.hasData) {
                final dataRestaurant = state.responseRestaurang.restaurants;
                return Expanded(
                  child: RefreshIndicator(
                    color: Colors.blue,
                    onRefresh: () {
                      return state.restaurantApi.getRestaurant();
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      itemCount: dataRestaurant.length,
                      itemBuilder: (context, index) {
                        var data = state.responseRestaurang.restaurants[index];
                        return CardRestaurant(
                          dataRestaurant: data,
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
    );
  }
}
