import 'package:final_project_restaurant_app/data/model/search_restaurant_response.dart';
import 'package:final_project_restaurant_app/page/restaurant/detail_restaurant_page.dart';
import 'package:flutter/material.dart';

class CardSearchWidgets extends StatelessWidget {
  final Restaurant dataSearch;
  const CardSearchWidgets({super.key, required this.dataSearch});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag:
            "https://restaurant-api.dicoding.dev/images/large/${dataSearch.pictureId}",
        child: Image.network(
          "https://restaurant-api.dicoding.dev/images/large/${dataSearch.pictureId}",
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        dataSearch.name,
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
          Text(dataSearch.city),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailRestaurantPage(
            id: dataSearch.id,
          ),
        ));
      },
    );
  }
}
