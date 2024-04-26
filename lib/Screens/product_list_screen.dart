import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:employee/screens/list_product_screen.dart';
import 'package:employee/Services/product_service.dart';

import '../Services/product_service.dart';

class ListBelanjaScreen extends StatelessWidget {
  final ShoppingService _shoppingService = ShoppingService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Produk'),
        actions: <Widget>[
          SizedBox(height: 1),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 16.0,
                  right: 16.0), // Memberikan ruang di atas dan di kanan FAB
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShoppingListScreen()),
                  );
                },
                child: Icon(Icons.arrow_back),
                backgroundColor: Colors.red, // Ubah warna latar belakang FAB
                elevation: 4, // Berikan efek bayangan pada FAB
                splashColor:
                Colors.white, // Ubah warna efek splash saat FAB ditekan
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<Map<String, String>>(
              stream: _shoppingService.getShoppingList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, String> items = snapshot.data!;
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final key = items.keys.elementAt(index);
                      final item = items[key];
                      return ListTile(
                        title: Text(item!),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _shoppingService.removeShoppingItem(key);
                          },
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}