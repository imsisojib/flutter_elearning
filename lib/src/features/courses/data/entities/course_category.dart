class CourseCategory{
  //table field names for Firebase
  static const String keyId = "id";
  static const String keyName = "name";
  static const String keyThumb = "thumbnail";

  String? id;
  String? name;
  String? thumbnail;

  CourseCategory.fromJson(Map<String, Object?> json){
    id = json[keyId] as String?;
    name = json[keyName] as String?;
    thumbnail = json[keyThumb] as String?;
  }

  @override
  String toString() {
    return 'CourseCategory{id: $id, name: $name, thumbnail: $thumbnail}';
  }
}