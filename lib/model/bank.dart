

class Bank{
  String bankCode;
  String name;
  Bank({this.name, this.bankCode});
  @override


  factory Bank.fromJson(Map<String, dynamic> parsedJson) {
    return Bank(
        bankCode: parsedJson["id"] as String,
        name: parsedJson["name"] as String,

    );
  }


}