import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShoppingService {
  final DatabaseReference _database =
  FirebaseDatabase.instance.ref().child('shopping_list');

  Stream<Map<String, String>> getShoppingList() {
    return _database.onValue.map((event) {
      final Map<String, String> items = {};
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          items[key] =
          'name\t\t:${value['name']} \nkode\t\t\t\t: ${value['kode']}';
        });
      }
      return items;
    });
  }

  void addShoppingItem(String name, kode, BuildContext context) {
    if (name.isEmpty || kode.isEmpty) {
      const warning = SnackBar(content: Text("Data yang diinput harus diisi"));
      ScaffoldMessenger.of(context).showSnackBar(warning);
    } else {
      _database.push().set({'name': name, 'kode': kode});
    }
  }

  Future<void> removeShoppingItem(String key) async {
    await _database.child(key).remove();
  }
}