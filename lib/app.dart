import 'package:flutter/material.dart';
import 'package:restapi/product_list_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductList(),
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
          errorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white
        )
      ),
    );
  }
}
