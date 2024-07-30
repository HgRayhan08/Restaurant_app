import 'package:final_project_restaurant_app/data/api/restaurant_api.dart';
import 'package:final_project_restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DetailRestaurantPage extends StatelessWidget {
  static const routeName = "/Detailarticle";
  String id;
  DetailRestaurantPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Restaurant"),
      ),
      body: ChangeNotifierProvider(
        create: (context) => DetailRestaurantProvider(
          restaurantApi: RestaurantApi(),
          id: id,
        ),
        child: Column(
          children: [
            Consumer<DetailRestaurantProvider>(builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state.state == ResultState.hasData) {
                var dataDetail = state.responseDetail.restaurant;
                return Expanded(
                  child: Column(
                    children: [
                      Hero(
                        tag:
                            "https://restaurant-api.dicoding.dev/images/large/${dataDetail.pictureId}",
                        child: Image.network(
                          "https://restaurant-api.dicoding.dev/images/large/${dataDetail.pictureId}",
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.3,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(15),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dataDetail.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 18,
                                    ),
                                    Text(
                                      dataDetail.city,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 18,
                                    ),
                                    Text(
                                      "${dataDetail.rating}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(),
                            const Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 5),
                              child: Text(
                                "Deskripsi",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              dataDetail.description,
                              textAlign: TextAlign.justify,
                            ),
                            const Divider(),
                            const Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 5),
                              child: Text(
                                "Menu",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        child: Text(
                                          "Foods",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            dataDetail.menus.foods.length,
                                        itemBuilder: (context, index) {
                                          return Text(
                                            "${index + 1}. ${dataDetail.menus.foods[index].name}",
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        child: Text(
                                          "Drinks",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            dataDetail.menus.drinks.length,
                                        itemBuilder: (context, index) {
                                          return Text(
                                            "${index + 1}. ${dataDetail.menus.drinks[index].name}",
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
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
            }),
          ],
        ),
      ),
    );
  }
}
