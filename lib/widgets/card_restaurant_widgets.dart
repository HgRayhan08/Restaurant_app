import 'package:final_project_restaurant_app/data/model/list_restaurant_response.dart';
import 'package:final_project_restaurant_app/page/restaurant/detail_restaurant_page.dart';
import 'package:final_project_restaurant_app/provider/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CardRestaurant extends StatelessWidget {
  late Restaurant dataRestaurant;
  CardRestaurant({super.key, required this.dataRestaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isRestaurant(dataRestaurant.id),
          builder: (context, snapshot) {
            var isBookmark = snapshot.data ?? false;
            return ListTile(
              leading: Hero(
                tag:
                    "https://restaurant-api.dicoding.dev/images/large/${dataRestaurant.pictureId}",
                child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/large/${dataRestaurant.pictureId}",
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                dataRestaurant.name,
                style: Theme.of(context).brightness == Brightness.dark
                    ? Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.white, fontSize: 18)
                    : Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.black, fontSize: 18),
              ),
              subtitle: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 18,
                  ),
                  Text(dataRestaurant.city),
                ],
              ),
              trailing: isBookmark
                  ? IconButton(
                      onPressed: () {
                        provider.removeBookmark(dataRestaurant.id);
                      },
                      icon: const Icon(Icons.bookmark),
                    )
                  : IconButton(
                      onPressed: () {
                        provider.addRestaurant(dataRestaurant);
                      },
                      icon: const Icon(Icons.bookmark_border),
                    ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailRestaurantPage(
                    id: dataRestaurant.id,
                  ),
                ));
              },
            );
          },
        );
      },
    );
  }
}
