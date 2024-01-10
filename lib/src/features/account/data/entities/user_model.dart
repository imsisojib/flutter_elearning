class UserModel{
  //table field names for Firebase
  static const String keyUid = "uid";
  static const String keyFirstName = "first_name";
  static const String keyLastName = "last_name";
  static const String keyEmail = "email";
  static const String keyRole = "role";
  static const String keyPhoneNumber = "phone_number";
  static const String keyProfilePicture = "profile_picture";
  static const String keyBirthdate = "birthdate";
  static const String keyCountry = "country";

  String? uid;
  String? firstName;
  String? lastName;
  String? email;
  String? role;
  String? phoneNumber;
  String? profilePicture;
  String? birthdate;
  String? country;

  UserModel.fromJson(Map<String, Object?> json){
    firstName = json[keyFirstName] as String?;
    lastName = json[keyLastName] as String?;
    email = json[keyEmail] as String?;
    uid = json[keyUid] as String?;
    phoneNumber = json[keyPhoneNumber] as String?;
    role = json[keyRole] as String?;
    profilePicture = json[keyProfilePicture] as String?;
    birthdate = json[keyBirthdate] as String?;
    country = json[keyCountry] as String?;
  }

  @override
  String toString() {
    return 'UserModel{uid: $uid, firstName: $firstName, lastName: $lastName, email: $email, role: $role, phoneNumber: $phoneNumber, profilePicture: $profilePicture, birthdate: $birthdate, country: $country}';
  }
}