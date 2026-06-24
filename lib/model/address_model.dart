class AddressModel {
  String id;
  String type;
  String houseNo;
  String building;
  String landmark;
  String address;

  AddressModel({
    required this.id,
    required this.type,
    required this.houseNo,
    required this.building,
    required this.landmark,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type": type,
      "houseNo": houseNo,
      "building": building,
      "landmark": landmark,
      "address": address,
    };
  }
}