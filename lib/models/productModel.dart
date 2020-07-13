import 'package:maverick_2245_r/models/reviewModel.dart';
import 'package:maverick_2245_r/models/sellerModel.dart';

//This is Product Model

class Product {
  String name;
  String description;
  String currency;
  int price;
  String rating;
  int ratingcount;
  List<String> images;
  List<Review> reviewlist;
  List<String> tags;
  Seller seller;
  Product(
      {this.name,
      this.description,
      this.currency,
      this.price,
      this.rating,
      this.ratingcount,
      this.images,
      this.reviewlist,
      this.tags,
      this.seller});

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    print("came");
    List<String> imageslist = new List<String>();
    List<Review> reviewlistcopy = new List<Review>();
    List<String> tagscopy = new List<String>();
    for (int i = 0;
        i < parsedJson['data']['product'][0]['Images'].length;
        i++) {
      print((parsedJson['data']['product'][0]['Images'][i]['url']).toString());
      imageslist.add(
          (parsedJson['data']['product'][0]['Images'][i]['url']).toString());
    }
    print("came");
    for (int i = 0; i < parsedJson['data']['product'][0]['reviews'].length; i++)
      reviewlistcopy.add(
        Review(
          name: parsedJson['data']['product'][0]['reviews'][i]['name'],
          profileurl: parsedJson['data']['product'][0]['reviews'][i]
              ['profile_url'],
          review: parsedJson['data']['product'][0]['reviews'][i]['review'],
          rating: (parsedJson['data']['product'][0]['reviews'][i]['rating'])
              .toString(),
        ),
      );
    print("came");
    for (int i = 0;
        i < parsedJson['data']['product'][0]['product_tags'].length;
        i++) {
      print(parsedJson['data']['product'][0]['product_tags'][i]['tag']
              ['tag']);
      tagscopy.add((parsedJson['data']['product'][0]['product_tags'][i]['tag']
              ['tag'])
          .toString());
    }
    Seller sellercopy = new Seller(
      name: parsedJson['data']['product'][0]['Seller']['Name'],
      id: parsedJson['data']['product'][0]['Seller']['ID'],
      rating: (parsedJson['data']['product'][0]['Seller']['seller_rating'])
          .toString(),
      profile: parsedJson['data']['product'][0]['Seller']['seller_profile'],
    );
    print("came");
    return Product(
      name: parsedJson['data']['product'][0]['name'],
      description: parsedJson['data']['product'][0]['description'],
      currency: parsedJson['data']['product'][0]['currency'],
      price: (parsedJson['data']['product'][0]['price']),
      rating: (parsedJson['data']['product'][0]['rating']).toString(),
      ratingcount: (parsedJson['data']['product'][0]['ratingCount']),
      images: imageslist,
      reviewlist: reviewlistcopy,
      tags: tagscopy,
      seller: sellercopy,
    );
  }
}
