class ListUser {
  final List<String> name;

  ListUser({this.name});
  factory ListUser.fromJsonData(Map<String, dynamic> json) {
    var list = json['UserList'];
    List<String> first = list.cast<String>();
    return new ListUser(
      name: first,
    );
  }
}
