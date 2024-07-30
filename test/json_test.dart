import 'package:final_project_restaurant_app/data/model/list_restaurant_response.dart';
import 'package:flutter_test/flutter_test.dart';

var testRestaurant = {
  "id": "8maika7giinkfw1e867",
  "name": "Rumah Senja",
  "description":
      "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
  "pictureId": "23",
  "city": "Bandung",
  "rating": 3.9
};

void main() {
  test("Test JSON Sucsess", () async {
    var result = Restaurant.fromJson(testRestaurant).id;

    expect(result, "8maika7giinkfw1e867");
  });
}
