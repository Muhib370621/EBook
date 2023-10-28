import 'package:cloud_firestore/cloud_firestore.dart';

class TopAuthors1{
  final String? image;
  final String? numberOfBook;
  final String? authorName;
  final String? authorCountry;
  final List<AuthorPopularBook>? othorBook;

  TopAuthors1({this.image, this.numberOfBook, this.authorName,this.authorCountry,this.othorBook});





  Map<String, dynamic> toJson(bool isAdd) {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['image'] = image;
    data['numberOfBook'] = numberOfBook;
    data['authorName'] = authorName;
    data['authorCountry'] = authorCountry;


    data['othorBook']= othorBook!.map((phone) => phone.toJson()).toList();

  return data;
  }


}




class AuthorPopularBook{
  final String? image;
  final String? bookName;
  final String? publishYear;

  AuthorPopularBook({this.image, this.bookName, this.publishYear});


  Map<String, dynamic> toJson() {

    return {
      "image": image,
      "bookName": bookName,
      'publishYear': publishYear,


    };

  }


}

class TopAuthors{
  String? image;
  String? authorName;
  String? id;
  String? desc;
  String? refId;
  String? designation;
  String? faceUrl;
  String? instUrl;
  String? twitUrl;
  String? youUrl;
  String? webUrl;
  int? view = 0;

  int? index;
  bool? isActive=true;

  TopAuthors({this.view,this.webUrl,this.youUrl,this.twitUrl,this.instUrl,this.faceUrl,this.image,  this.authorName,this.id,this.desc,this.refId,this.designation,this.index,this.isActive});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['image'] = image;
    data['authorName'] = authorName;
    data['desc'] = desc;
    data['refId'] = refId;
    data['designation'] = designation;
    data['index'] = index;
    data['facebook_url'] = faceUrl;
    data['instagram_url'] = instUrl;
    data['twitter_url'] = twitUrl;
    data['youtube_url'] = youUrl;
    data['website_url'] = webUrl;
    data['is_active'] = isActive;
    data['view'] = view;

    return data;
  }


  factory TopAuthors.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return TopAuthors(
      id: doc.id,
      image: data['image'],
      authorName: data['authorName'],
      desc: data['desc'],
      refId: data['refId'],
      designation: data['designation'],
      index: data['index'],
      faceUrl: data['facebook_url'],
      instUrl: data['instagram_url'],
      twitUrl: data['twitter_url'],
      youUrl: data['youtube_url'],
      webUrl: data['website_url'],
      view: data['view'],
      isActive: data['is_active']??false,
    );
  }

}





