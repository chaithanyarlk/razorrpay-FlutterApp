import 'package:flutter/material.dart';
import 'package:maverick_2245_r/models/productModel.dart';
import 'package:maverick_2245_r/screens/orderSummary.dart';
import 'package:maverick_2245_r/screens/productDetailPage.dart';

void main() {
  
  //WidgetsFlutterBinding.ensureInitialized();
  //Product product = await loadproduct();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var product;

  // This widget is the root of your application.
  MyApp({this.product});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProductPage(),
    );
  }
}
