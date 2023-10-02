import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../response/categories_response.dart';

class NewsController extends GetxController {
  var isLoading = false.obs;
  var data;
  List result = [].obs;
  final htmlContactContent = "".obs;

  ///fetch title,image,description etc..

  Future fetchData({required String id, required int page}) async {
    try {
      isLoading(true);
      http.Response response =
          await http.get(Uri.tryParse('http://travelspan.in/wp-json/wp/v2/posts?_embed&categories=$id&per_page=100&page=$page')!);

      if (response.statusCode == 200) {
        result = jsonDecode(response.body);
        // data = await result
        //     .map((job) => CargoNewWireNewsResponse.fromJson(job))
        //     .toList();
      } else {
        return Future.error("Server Error");
      }
    } catch (SocketException) {
      return Future.error("Error Fetching data");
    } finally {
      isLoading(false);
    }
    return result;
  }

  ///fetch title,image,description etc..

  Future fetchLatestData() async {
    try {
      isLoading(true);
      http.Response response = await http.get(Uri.tryParse('https://travelspan.in/wp-json/wp/v2/posts?_embed&per_page=20')!);

      if (response.statusCode == 200) {
        result = jsonDecode(response.body);
      } else {
        return Future.error("Server Error");
      }
    } catch (SocketException) {
      return Future.error("Error Fetching data");
    } finally {
      isLoading(false);
    }
    return result;
  }

  ///fetch Categories

  Future<List> fetchCategories() async {
    try {
      isLoading(true);
      http.Response response = await http.get(Uri.tryParse('https://travelspan.in/wp-json/wp/v2/categories?per_page=100&page=1')!);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        data = await result.map((job) => CategoriesResponse.fromJson(job)).toList();
      } else {
        return Future.error("Server Error");
      }
    } catch (SocketException) {
      return Future.error('Error Fetching data');
    } finally {
      isLoading(false);
    }
    return data;
  }

  ///Get related post
  Future<List> fetchRelatedPost({required String categoryId}) async {
    // try {
    isLoading(true);
    http.Response response = await http.get(Uri.tryParse('https://cargonewswire.com/wp-json/wp/v2/posts/?categories=$categoryId&per_page=5')!);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      data = await result.map((job) => CategoriesResponse.fromJson(job)).toList();
    } else {
      return Future.error("Server Error");
      // }
      // } catch (SocketException) {
      //   return Future.error('Error Fetching data');
      // } finally {
      isLoading(false);
    }
    return data;
  }

  ///Search Post
  Future<List> searchPost({required String searchTerm}) async {
    try {
      print(searchTerm);
      isLoading(true);
      http.Response response = await http.get(Uri.tryParse(
          'https://travelspan.in/index.php/wp-json/wp/v2/posts?search=$searchTerm&subtype[]=post&_embed&orderby=date&order=desc&per_page=100')!);
      print(response.body);

      if (response.statusCode == 200) {
        print("saved");
        result = jsonDecode(response.body);

        // data = await result
        //     .map((job) => CargoNewWireNewsResponse.fromJson(job))
        //     .toList();
      } else {
        return Future.error("Server Error");
      }
    } catch (SocketException) {
      return Future.error('Error Fetching data');
    } finally {
      isLoading(false);
    }
    return result;
  }

  Future<void> fetchContactUsPage() async {
    final response = await http.get(Uri.parse('https://travelspan.in/contact/'));
    if (response.statusCode == 200) {
      htmlContactContent.value = response.body;
    }
  }

  ///fetch Main Categories and Sub-categories--not in use rn

// Future<List<Category>> fetchParentCategories() async {
//   final response = await http.get(Uri.parse(
//       'https://cargonewswire.com/wp-json/wp/v2/categories?parent=0&per_page=100'));
//
//   if (response.statusCode == 200) {
//     print("object");
//     final List<dynamic> categoriesJson = jsonDecode(response.body);
//     final List<Category> categories = [];
//
//     for (final categoryJson in categoriesJson) {
//       final subcategoriesResponse = await http.get(Uri.parse(
//           'https://cargonewswire.com/wp-json/wp/v2/categories?parent=${categoryJson['id']}&per_page=20'));
//
//       if (subcategoriesResponse.statusCode == 200) {
//         final List<dynamic> subcategoriesJson =
//             jsonDecode(subcategoriesResponse.body);
//         final List<Subcategory> subcategories =
//             subcategoriesJson.map((subcategoryJson) {
//           return Subcategory(
//             id: subcategoryJson['id'],
//             name: subcategoryJson['name'],
//             slug: subcategoryJson['slug'],
//           );
//         }).toList();
//
//         categories.add(Category(
//           id: categoryJson['id'],
//           name: categoryJson['name'],
//           slug: categoryJson['slug'],
//           subcategories: subcategories,
//         ));
//       }
//     }
//
//     return categories;
//   } else {
//     throw Exception('Failed to load categories');
//   }
// }
}
