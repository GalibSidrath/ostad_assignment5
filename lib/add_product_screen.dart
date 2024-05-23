import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool _processIngoing = false;
  final TextEditingController _nameTEcontroller = TextEditingController();
  final TextEditingController _unitPriceTEcontroller = TextEditingController();
  final TextEditingController _totalPriceTEcontroller = TextEditingController();
  final TextEditingController _quantityTEcontroller = TextEditingController();
  final TextEditingController _productCodeTEcontroller =
      TextEditingController();
  final TextEditingController _productImageTEcontroller =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    _nameTEcontroller.dispose();
    _unitPriceTEcontroller.dispose();
    _totalPriceTEcontroller.dispose();
    _quantityTEcontroller.dispose();
    _productCodeTEcontroller.dispose();
    _productImageTEcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new product'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Add new product',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _nameTEcontroller,
                        decoration: InputDecoration(labelText: 'Product Name'),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please fill up the text field with proper information';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _productCodeTEcontroller,
                        decoration: InputDecoration(labelText: 'Product Code'),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please fill up the text field with proper information';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _unitPriceTEcontroller,
                        decoration: InputDecoration(labelText: 'Unit Price'),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please fill up the text field with proper information';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _quantityTEcontroller,
                          decoration: InputDecoration(labelText: 'Quantity'),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please fill up the text field with proper information';
                            }
                            return null;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _totalPriceTEcontroller,
                        decoration: InputDecoration(labelText: 'Total Price'),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please fill up the text field with proper information';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _productImageTEcontroller,
                        decoration: InputDecoration(labelText: 'Product Image'),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please fill up the text field with proper information';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                          width: double.maxFinite,
                          child: Visibility(
                            visible: !_processIngoing,
                            replacement: Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    _addNewProduct();
                                  }
                                },
                                child: Text('Add')),
                          )),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _addNewProduct() async {
    _processIngoing = true;
    setState(() {});
    const String addProductUrl =
        'https://crud.teamrabbil.com/api/v1/CreateProduct';
    Uri uri = Uri.parse(addProductUrl);

    Map<String, dynamic> inputData = {
      "ProductName": _nameTEcontroller.text,
      "ProductCode": _productCodeTEcontroller.text,
      "Img": _productImageTEcontroller.text.trim(),
      "UnitPrice": _unitPriceTEcontroller.text,
      "Qty": _quantityTEcontroller.text,
      "TotalPrice": _totalPriceTEcontroller.text,
    };

    Response response = await post(uri,
        body: jsonEncode(inputData),
        headers: {'content-type': 'application/json'});
    if (response.statusCode == 200) {
      // _nameTEcontroller.clear();
      // _unitPriceTEcontroller.clear();
      // _totalPriceTEcontroller.clear();
      // _quantityTEcontroller.clear();
      // _productCodeTEcontroller.clear();
      // _productImageTEcontroller.clear();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('New product add successfull!')));
      Navigator.pop(context, true);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed! Try again')));
    }

    _processIngoing = false;

    setState(() {});
  }
}
