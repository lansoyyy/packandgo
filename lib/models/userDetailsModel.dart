// ignore_for_file: file_names

class UserDetailsMODEL {
  String? userType;
  String? firstname;
  String? lastname;
  String? contactNumber;
  String? email;

  UserDetailsMODEL(
      {this.userType,
      this.firstname,
      this.lastname,
      this.contactNumber,
      this.email});

  UserDetailsMODEL.fromJson(Map<String, dynamic> json) {
    userType = json['userType'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    contactNumber = json['contactNumber'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userType'] = userType;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['contactNumber'] = contactNumber;
    data['email'] = email;
    return data;
  }
}

class UserData {
  final String uid;
  final String? email;

  UserData(this.uid, this.email);
}
