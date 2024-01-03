class UserModel{
  //table field names
  static const String keyUid = "uid";
  static const String keyFullName = "full_name";
  static const String keyRole = "role";
  static const String keyPhoneNumber = "phone_number";
  static const String keyProfilePicture = "profile_picture";

  String? uid;
  String? fullName;
  String? role;
  String? phoneNumber;
  String? profilePicture;

  UserModel.fromJson(Map<String, Object?> json){
    fullName = json[keyFullName] as String?;
    uid = json[keyUid] as String?;
    phoneNumber = json[keyPhoneNumber] as String?;
    role = json[keyRole] as String?;
    profilePicture = json[keyProfilePicture] as String?;
  }

  @override
  String toString() {
    return 'UserModel{uid: $uid, fullName: $fullName, role: $role, phoneNumber: $phoneNumber, profilePicture: $profilePicture}';
  }
}