import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_read_more_text/flutter_read_more_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maverick_2245_r/models/productModel.dart';
import 'package:maverick_2245_r/screens/orderSummary.dart';

Future<String> _loadAProductAsset() async {
  return await rootBundle.loadString('assets/product.json');
}

Future<Product> loadproduct() async {
  await wait(5);
  String jsonString = await _loadAProductAsset();
  final jsonResponse = json.decode(jsonString);
  return new Product.fromJson(jsonResponse);
}

Future wait(int seconds) {
  return new Future.delayed(Duration(seconds: seconds), () => {});
}

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool _loading;
  var _price;
  var image;
  var _rating, _ratingCount;
  PageController _controller1 = PageController(
    initialPage: 0,
  );
  @override
  void dispose() {
    _controller1.dispose();
    super.dispose();
  }

  Widget futureWidget() {
    return new FutureBuilder<Product>(
      future: loadproduct(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _price = snapshot.data.price;
          _rating = snapshot.data.rating;
          _ratingCount = snapshot.data.ratingcount;
          return new GestureDetector(
            onTap: (){
              setState(() {
                _price = snapshot.data.price;
          _rating = snapshot.data.rating;
          _ratingCount = snapshot.data.ratingcount;
              });
              
            },
            child:Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      margin: EdgeInsets.only(top: 0.0, bottom: 16.0),
                      child: PageView(
                        controller: _controller1,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Image.network(
                            snapshot.data.images[0],
                            fit: BoxFit.fitWidth,
                          ),
                          Image.network(
                            snapshot.data.images[1],
                            fit: BoxFit.fitWidth,
                          ),
                          Image.network(
                            snapshot.data.images[2],
                            fit: BoxFit.fitWidth,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 7.5,
                      child: Container(
                        margin: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                        ),
                        child: new Icon(
                          Icons.navigate_before,
                          color: Colors.black,
                          size: 35.0,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 25.0,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                            ),
                            child: new Icon(
                              Icons.more_vert,
                              color: Colors.black,
                              size: 35.0,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                            ),
                            child: new Icon(
                              EvaIcons.heartOutline,
                              color: Colors.black,
                              size: 35.0,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                            ),
                            child: new Icon(
                              Icons.share,
                              color: Colors.black,
                              size: 35.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 8.0, bottom: 5.0, left: 8.0, right: 8.0),
                  child: Text(
                    "${snapshot.data.name}",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.0, bottom: 8.0, left: 5.0),
                  child: Text(
                    "Physical Good - New",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 8.0, bottom: 5.0, left: 8.0, right: 8.0),
                  child: Text(
                    "Features :",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ReadMoreText("${snapshot.data.description}"),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Container(
                    height: 2.0,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[500],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 8.0, bottom: 5.0, left: 8.0, right: 8.0),
                  child: Text(
                    "Reviews :",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                snapshot.data.reviewlist.length == 0
                    ? Text("No one has Reviewed!")
                    : ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 10.0),
                                  width: 45.0,
                                  height: 45.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: new NetworkImage(snapshot
                                          .data.reviewlist[index].profileurl
                                          .toString()),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 10.0,
                                        spreadRadius: 5.0,
                                        offset: Offset(5.0, 5.0),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.0,
                                            right: 1.0,
                                            top: 1.0,
                                            bottom: 1.0),
                                        child: Container(
                                          //margin: EdgeInsets.only(left: 2.0,right:2.0),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          height: 20.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(1.0),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.0),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.0),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(1.0),
                                                child: Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.0,
                                            top: 3.0,
                                            bottom: 3.0,
                                            right: 3.0),
                                        child: Text(
                                          "${snapshot.data.reviewlist[index].name}",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 5.0,
                                            top: 3.0,
                                            bottom: 3.0,
                                            right: 3.0),
                                        child: Text(
                                            "${snapshot.data.reviewlist[index].review}",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w800)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        itemCount: snapshot.data.reviewlist.length,
                      ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Container(
                    height: 2.0,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[500],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 8.0, bottom: 5.0, left: 8.0, right: 8.0),
                  child: Text(
                    "Tags :",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 5.0,
                      children: <Widget>[
                        snapshot.data.tags.length == 0
                            ? Text("No Tags")
                            : ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) => RaisedButton(
                                  color: Colors.white70,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.black),
                                  ),
                                  onPressed: null,
                                  child: Text(
                                    "${snapshot.data.tags[index].toString()}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                itemCount: snapshot.data.tags.length,
                              ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Container(
                    height: 2.0,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[500],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 8.0, bottom: 5.0, left: 8.0, right: 8.0),
                  child: Text(
                    "About the Seller :",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10.0),
                          width: 45.0,
                          height: 45.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: new NetworkImage(
                                  snapshot.data.seller.profile.toString()),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 10.0,
                                spreadRadius: 5.0,
                                offset: Offset(5.0, 5.0),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text("${snapshot.data.seller.name}",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 15)),
                              ),
                              Container(
                                height: 20.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: Text(
                                          "(${snapshot.data.ratingcount})",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w200)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5.0),
                                height: 25.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 25,
                                      width: 25.0,
                                    ),
                                    RaisedButton(
                                      color: Colors.white70,
                                      splashColor: Colors.yellow,
                                      onPressed: () {},
                                      child: const Text('View Store',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.grey)),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                      width: 25.0,
                                    ),
                                    RaisedButton(
                                      color: Colors.white70,
                                      splashColor: Colors.yellow,
                                      onPressed: () {},
                                      child: const Text('Message',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.grey)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
              ],
            ),
          ),
          );
        } else if (snapshot.hasError) {
          return new Text("${snapshot.error}");
        }
        
        return new Center(
          child: new Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new CircularProgressIndicator(),
                new Center(
                  child:Text("Tap on the Product Name to know it's price")
                ),
              
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              futureWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: new Container(
        width: MediaQuery.of(context).size.width,
        height: 55.0,
        decoration: BoxDecoration(
          color: Colors.black87,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: 1.0,
                  bottom: 1.0,
                  right: MediaQuery.of(context).size.width / 3),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Text(
                        "Rs.${_price}",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(1.0),
                            child: new Icon(
                              Icons.star,
                              color: Colors.red,
                              size: 20.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(1.0),
                            child: Text(
                              "${_rating} (${_ratingCount})",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(3.0),
              child: RaisedButton(
                color: Colors.yellow,
                textColor: Colors.white70,
                child: Text(
                  "Buy Now",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(
                                      builder: (context) =>
                                          new OrderPage()),);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
