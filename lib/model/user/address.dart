abstract class Address {
  String street;
  String city;
  String state;
  String country;
}

class UserAddress implements Address {
  @override
  String street;
  @override
  String city;

  @override
  String country;

  @override
  String state;

  UserAddress({this.street, this.city, this.country, this.state});
}
