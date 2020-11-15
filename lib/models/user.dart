class NewUser // a custom class which only stores used id from the firebase obj returned
{
  final String uid;
  NewUser({this.uid});
}
// class for storing user information
class userinfo {
  String name, enrollno;
  int type;
  userinfo(String name, String enrollno, int type) {
    this.name = name;
    this.type = type;
    this.enrollno = enrollno;
  }
  String getname() {
    return name;
  }

  String getenrollno() {
    return enrollno;
  }

  int gettype() {
    return type;
  }
}
