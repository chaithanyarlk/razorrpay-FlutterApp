class Seller {
  String name;
  String id;
  String rating;
  String profile;
  Seller({this.id, this.name, this.rating, this.profile});
  
  factory Seller.fromJson(Map<String, dynamic> parsedJson) {
    return Seller(
      name:parsedJson['data']['product'][0]['Seller']['Name'],
      id:parsedJson['data']['product'][0]['Seller']['ID'],
      rating: parsedJson['data']['product'][0]['Seller']['seller_rating'],
      profile:parsedJson['data']['product'][0]['Seller']['seller_profile'],
      );
  }
}
