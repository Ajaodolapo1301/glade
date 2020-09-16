
class User {
  String firstname;
  String lastname;
  String dob;
  String bvn;
  String phone;

  User({this.bvn, this.dob, this.firstname, this.lastname, this.phone});


  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
      firstname: parsedJson["firstname"] as String,
      lastname: parsedJson["lastname"] as String,
      dob: parsedJson["dob"] as String,
      bvn: parsedJson["bvn"] as String,
      phone: parsedJson["phone"] as String,

    );
  }

}