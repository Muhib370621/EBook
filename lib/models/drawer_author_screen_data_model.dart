class AuthorDataModel{
  final String? name;
  final String? image;
  final String? description;
  final String? designation;
  bool? status ;
  final int? id;

  AuthorDataModel(
      {this.name, this.image, this.description, this.designation, this.id,this.status});
}