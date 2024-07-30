import 'package:final_project_restaurant_app/provider/database_provider.dart';
import 'package:final_project_restaurant_app/widgets/card_restaurant_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookMarkPage extends StatelessWidget {
  const BookMarkPage({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BookMark"),
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.hasData) {
            var dataBookmark = provider.restaurant;
            return ListView.builder(
              itemCount: dataBookmark.length,
              itemBuilder: (context, index) {
                return CardRestaurant(
                    dataRestaurant: provider.restaurant[index]);
              },
            );
          } else {
            return Center(
              child: Material(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.warning,
                      size: 150,
                    ),
                    Text(provider.message),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
