import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restapi/add_product_screen.dart';
import 'package:restapi/product_model.dart';
import 'package:restapi/update_product_screen.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool _inProcess = false;
  List<ProductModel> _product_list = [];
  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: RefreshIndicator(
        onRefresh: _getProductList,
        child: Visibility(
          visible: !_inProcess,
          replacement: Center(
            child: CircularProgressIndicator(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Product List',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          final res = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddProduct()));
                          if(res){
                            _getProductList();
                          }
                        },
                        child: Text('Add a new product'))
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: _product_list.length,
                  itemBuilder: (context, index) {
                    return _buildData(_product_list[index]);
                  },
                  separatorBuilder: (_, __) => const Divider(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildData(ProductModel product) {
    return Expanded(
      child: ListTile(
        // leading: Image.network('${product.img}'),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name :  ${product.productName ?? 'Unknown'}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Unit Price :  ${product.unitPrice ?? 'Unknown'}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Quantaty : ${product.qty ?? 'Unknown'}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Total Price : ${product.totalPrice ?? 'Unknown'}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
        trailing: Wrap(
          spacing: 16,
          children: [
            IconButton(
                onPressed: () async {
                  final result = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return UpdateProduct(product: product);
                  }));
                  if (result) {
                    _getProductList();
                  }
                },
                icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Delete'),
                          content: Text('Are you sure to delete?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  _deleteProduct(product.id!);
                                  Navigator.pop(context);
                                },
                                child: Text('Yes')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('No')),
                          ],
                        );
                      });
                },
                icon: Icon(Icons.delete))
          ],
        ),
      ),
    );
  }

  Future<void> _getProductList() async {
    _inProcess = true;
    _product_list.clear();
    setState(() {});
    String getProductUrl = 'https://crud.teamrabbil.com/api/v1/ReadProduct';
    Uri uri = Uri.parse(getProductUrl);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      final decode = jsonDecode(response.body);
      List getData = decode['data'];
      for (Map i in getData) {
        _product_list.add(ProductModel.fromJson(i));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Unable to get data')));
    }
    _inProcess = false;
    setState(() {});
  }

  Future<void> _deleteProduct(String id) async {
    _inProcess = true;
    setState(() {});
    String _deleteProductUrl =
        'https://crud.teamrabbil.com/api/v1/DeleteProduct/$id';
    Uri uri = Uri.parse(_deleteProductUrl);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      _getProductList();
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Faild! Tray again')));
    }
    _inProcess = false;
    setState(() {});
  }
}
