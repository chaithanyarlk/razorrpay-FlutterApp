import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_read_more_text/flutter_read_more_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maverick_2245_r/models/productModel.dart';
import 'package:maverick_2245_r/screens/productDetailPage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  var _qty;
  var _price;
  var _rating;
  var _ratingCount;
  var _name;
  Razorpay _razorpay;
  FlutterToast flutterToast;
  @override
  void initState() {
    super.initState();
    flutterToast = FlutterToast(context);
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    _qty = 1;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }

  void _dec() {
    setState(() {
      if (_qty == 1) {
        
        _qty = 1;
      } else {
        _price = _price - (_price / _qty);
        _qty = _qty - 1;
      }
    });
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_Nb25lBivYkrV81',
      'amount': _price * 100, //in the smallest currency sub-unit.

      // Generate order_id using Orders API
      'description': _name,
      'prefill': {'contact': '9123456789', 'email': 'gaurav.kumar@example.com'},
      'external': {
        'wallets': ['paytm']
      },
    };
    try {
      _razorpay.open(options);
    } catch (ex) {
      print(ex.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    // ignore: unnecessary_statements
    flutterToast.showToast(
      child: Text("Success" + response.paymentId),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    flutterToast.showToast(
      child: Text("PaymentFailed" + response.message),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response.walletName);
    // Do something when an external wallet is selected
    flutterToast.showToast(
      child: Text("Error at " + response.walletName),
    );
  }

  void _inc() {
    setState(() {
      _price = _price + (_price / _qty);
      _qty++;
    });
  }

  Widget futureWidget() {
    return new FutureBuilder<Product>(
        future: loadproduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _price = _qty * snapshot.data.price;
            _rating = snapshot.data.rating;
            _ratingCount = snapshot.data.ratingcount;
            _name = snapshot.data.name;
            return new GestureDetector(
                child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              setState(() {
                                _price = snapshot.data.price;
                                _rating = snapshot.data.rating;
                                _ratingCount = snapshot.data.ratingcount;
                              });
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Image.network(
                              snapshot.data.images[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2.05,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text("${snapshot.data.name}",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w800))),
                              Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text("${snapshot.data.seller.name}",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w800))),
                              Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text("Rs ${snapshot.data.price}/Pcs",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w800))),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: 25.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 25.0,
                                      width: MediaQuery.of(context).size.width /
                                          7.5,
                                      child: RaisedButton(
                                        splashColor: Colors.yellow,
                                        onPressed: () {
                                          if(_qty!=1)
                                          _dec();
                                        },
                                        child: Icon(
                                          EvaIcons.minus,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25.0,
                                      width: MediaQuery.of(context).size.width /
                                          7.5,
                                      child: Center(
                                          child: Text("${_qty}",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight:
                                                      FontWeight.w800))),
                                    ),
                                    SizedBox(
                                      height: 25.0,
                                      width: MediaQuery.of(context).size.width /
                                          7.5,
                                      child: RaisedButton(
                                        splashColor: Colors.yellowAccent,
                                        onPressed: () {
                                          _inc();
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                      ),
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
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Container(
                      height: 2.0,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey[500],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Summary",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w800))),
                  Container(
                    padding: EdgeInsets.all(3.0),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2.05,
                          padding: EdgeInsets.all(3.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Text("${snapshot.data.name}",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w800))),
                              Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Text("Size : ${_qty} Kg",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w800))),
                              Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Text("Quantity : ${_qty}",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w800))),
                            ],
                          ),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 2.25,
                            child: Center(
                                child: Text(
                              "Rs ${snapshot.data.price * _qty}.00",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 18.0),
                            ))),
                      ],
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2.25,
                          child: Center(
                              child: Text(
                            "Total",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18.0),
                          )),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 2.25,
                            child: Center(
                                child: Text(
                              "Rs ${snapshot.data.price * _qty}.00",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 18.0),
                            ))),
                      ],
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
                  Container(
                    padding: EdgeInsets.all(5.0),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 1.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Shipping Address",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20.0)),
                              TextField(
                                maxLines: 5,
                                decoration: InputDecoration(
                                    hintText: "Enter your Address"),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.edit)
                      ],
                    ),
                  ),
                ],
              ),
            ));
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
                      child: Text("Tap on Product to activate payNow option")),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.navigate_before,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "CheckOut",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 20.0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: futureWidget(),
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
                  "Pay Now",
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                onPressed: () {
                  openCheckout();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
