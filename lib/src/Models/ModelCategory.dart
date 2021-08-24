class ModelCategory {
  String id,name,image,cat_store;
  // ModelCategory({this.id,this.name,this.image});
  ModelCategory(this.id,this.name,this.image);
  String get cat_image=>image;
  String get cat_name=>name;
  String get cat_id=>id;
 /* factory ModelCategory.set(id,name,image){
    return ModelCategory(id:id,name: name,image: image);
  }

  factory ModelCategory.fromJson(Map<String,dynamic> json) {
      return ModelCategory(id:json['id'],name:json['cat_name'],image:json['cat_image']);
  }*/
}