class Review {
  String name;
  String profileurl;
  String review;
  String rating;
  Review({this.name, this.profileurl, this.review, this.rating});

  factory Review.fromJson(Map<String, dynamic> parsedJson,int i) {
    return Review(
      name:parsedJson['data']['product'][0]['reviews'][i]['name'],
      profileurl: parsedJson['data']['product'][0]['reviews'][i]['profile_url'],
      review: parsedJson['data']['product'][0]['reviews'][i]['review'],
      rating: parsedJson['data']['product'][0]['reviews'][i]['rating'],
    );
  }
}
