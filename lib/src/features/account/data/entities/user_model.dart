class UserModel{
  //table field names for Firebase
  static const String keyUid = "uid";
  static const String keyFullName = "full_name";
  static const String keyRole = "role";
  static const String keyPhoneNumber = "phone_number";
  static const String keyProfilePicture = "profile_picture";
  static const String keyBirthdate = "birthdate";
  static const String keyCountry = "country";

  String? uid;
  String? fullName;
  String? role;
  String? phoneNumber;
  String? profilePicture;
  String? birthdate;
  String? country;

  UserModel.fromJson(Map<String, Object?> json){
    fullName = json[keyFullName] as String?;
    uid = json[keyUid] as String?;
    phoneNumber = json[keyPhoneNumber] as String?;
    role = json[keyRole] as String?;
    profilePicture = json[keyProfilePicture] as String?;
    birthdate = json[keyBirthdate] as String?;
    country = json[keyCountry] as String?;
  }

  @override
  String toString() {
    return 'UserModel{uid: $uid, fullName: $fullName, role: $role, phoneNumber: $phoneNumber, profilePicture: $profilePicture}';
  }
}