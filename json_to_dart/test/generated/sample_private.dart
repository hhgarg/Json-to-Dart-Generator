class Sample {
  String _username;
  int _favouriteInteger;
  double _favouriteDouble;
  String _url;
  String _htmlUrl;
  List<String> _tags;
  List<int> _randomIntegers;
  List<double> _randomDoubles;
  PersonalInfo _personalInfo;

  Sample(
      {String username,
      int favouriteInteger,
      double favouriteDouble,
      String url,
      String htmlUrl,
      List<String> tags,
      List<int> randomIntegers,
      List<double> randomDoubles,
      PersonalInfo personalInfo}) {
    _username = username;
    _favouriteInteger = favouriteInteger;
    _favouriteDouble = favouriteDouble;
    _url = url;
    _htmlUrl = htmlUrl;
    _tags = tags;
    _randomIntegers = randomIntegers;
    _randomDoubles = randomDoubles;
    _personalInfo = personalInfo;
  }

  String get username => _username;
  set username(String username) => _username = username;
  int get favouriteInteger => _favouriteInteger;
  set favouriteInteger(int favouriteInteger) =>
      _favouriteInteger = favouriteInteger;
  double get favouriteDouble => _favouriteDouble;
  set favouriteDouble(double favouriteDouble) =>
      _favouriteDouble = favouriteDouble;
  String get url => _url;
  set url(String url) => _url = url;
  String get htmlUrl => _htmlUrl;
  set htmlUrl(String htmlUrl) => _htmlUrl = htmlUrl;
  List<String> get tags => _tags;
  set tags(List<String> tags) => _tags = tags;
  List<int> get randomIntegers => _randomIntegers;
  set randomIntegers(List<int> randomIntegers) =>
      _randomIntegers = randomIntegers;
  List<double> get randomDoubles => _randomDoubles;
  set randomDoubles(List<double> randomDoubles) =>
      _randomDoubles = randomDoubles;
  PersonalInfo get personalInfo => _personalInfo;
  set personalInfo(PersonalInfo personalInfo) => _personalInfo = personalInfo;

  Sample.fromJson(Map<String, dynamic> json) {
    _username = json['username'];
    _favouriteInteger = json['favouriteInteger'];
    _favouriteDouble = json['favouriteDouble'];
    _url = json['url'];
    _htmlUrl = json['html_url'];
    _tags = json['tags'].cast<String>();
    _randomIntegers = json['randomIntegers'].cast<int>();
    _randomDoubles = json['randomDoubles'].cast<double>();
    _personalInfo = json['personalInfo'] != null
        ? PersonalInfo.fromJson(json['personalInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = _username;
    data['favouriteInteger'] = _favouriteInteger;
    data['favouriteDouble'] = _favouriteDouble;
    data['url'] = _url;
    data['html_url'] = _htmlUrl;
    data['tags'] = _tags;
    data['randomIntegers'] = _randomIntegers;
    data['randomDoubles'] = _randomDoubles;
    if (_personalInfo != null) {
      data['personalInfo'] = _personalInfo.toJson();
    }
    return data;
  }
}

class PersonalInfo {
  String _firstName;
  String _lastName;
  String _location;
  List<Phones> _phones;

  PersonalInfo(
      {String firstName,
      String lastName,
      String location,
      List<Phones> phones}) {
    _firstName = firstName;
    _lastName = lastName;
    _location = location;
    _phones = phones;
  }

  String get firstName => _firstName;
  set firstName(String firstName) => _firstName = firstName;
  String get lastName => _lastName;
  set lastName(String lastName) => _lastName = lastName;
  String get location => _location;
  set location(String location) => _location = location;
  List<Phones> get phones => _phones;
  set phones(List<Phones> phones) => _phones = phones;

  PersonalInfo.fromJson(Map<String, dynamic> json) {
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _location = json['location'];
    if (json['phones'] != null) {
      _phones = <Phones>[];
      json['phones'].forEach((v) {
        _phones.add(Phones.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = _firstName;
    data['lastName'] = _lastName;
    data['location'] = _location;
    if (_phones != null) {
      data['phones'] = _phones.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Phones {
  String _type;
  String _number;
  bool _shouldCall;

  Phones({String type, String number, bool shouldCall}) {
    _type = type;
    _number = number;
    _shouldCall = shouldCall;
  }

  String get type => _type;
  set type(String type) => _type = type;
  String get number => _number;
  set number(String number) => _number = number;
  bool get shouldCall => _shouldCall;
  set shouldCall(bool shouldCall) => _shouldCall = shouldCall;

  Phones.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _number = json['number'];
    _shouldCall = json['shouldCall'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = _type;
    data['number'] = _number;
    data['shouldCall'] = _shouldCall;
    return data;
  }
}
