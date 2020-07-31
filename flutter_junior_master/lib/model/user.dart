class User {
  String id;
  String name;
  String birthdate;

  User({this.id, this.name, this.birthdate});

  List<User> items = new List();

  User.fromJsonMap(Map<String, dynamic> json) {
    id          = json['id']; 
    name        = json['name'];
    birthdate   = json['birthdate'];

  }

  User.fromJsonList ( List<dynamic> jsonList ) {

    if ( jsonList == null ) return;

    for ( var item in jsonList ) {
      final user = new User.fromJsonMap(item);
      items.add(user);
    }

  }
}