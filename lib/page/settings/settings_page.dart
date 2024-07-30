import 'package:final_project_restaurant_app/provider/preference.provider.dart';
// import 'package:final_project_restaurant_app/provider/scheduling_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: Consumer<PreferencesProvider>(builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text("Dark Theme"),
                trailing: Switch.adaptive(
                  value: provider.isdarkTheme,
                  onChanged: (value) {
                    provider.enableDarkTheme(value);
                  },
                ),
              ),
            ),
            Material(
              child: ListTile(
                title: const Text("Schrduling Recomendasi"),
                trailing: Switch.adaptive(
                  value: provider.isRecommended,
                  onChanged: (value) {
                    provider.enablerecommendedResto(value);
                  },
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
