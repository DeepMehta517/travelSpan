import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BookMarkController extends GetxController {
  final bookmark = [].obs;
  final box = GetStorage();
  final auth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance;

  ///for all
  addToBookmark(var value) {
    bookmark.add(value);

    if (auth.currentUser != null) {
      FirebaseDatabase.instance
          .ref()
          .child(auth.currentUser!.uid)
          .child(value["id"].toString())
          .push()
          .set(value);
    }
  }

  removeBookmark(var value) {
    bookmark.remove(value);
    if (auth.currentUser != null) {
      FirebaseDatabase.instance
          .ref()
          .child(auth.currentUser!.uid)
          .child(value["id"].toString())
          .remove();
    }

    store();
  }

  store() {
    // box.write('bookmarks', bookmark);
  }

  void loadBookmarks() {
    final bookmarksData = box.read('bookmarks');

    if (bookmarksData != null) {
      // print(bookmarksData);
      bookmark.value = bookmarksData;
    }
  }

  bool isBookmarked(var obj) {
    return bookmark.any((bookmark) => bookmark["id"] == obj["id"]);
  }

  @override
  void onInit() {
    super.onInit();
    // loadBookmarks();
  }
}
