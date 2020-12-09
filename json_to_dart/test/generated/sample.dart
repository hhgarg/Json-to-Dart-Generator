class Sample {
  String username;
  int favouriteInteger;
  double favouriteDouble;
  String url;
  String htmlUrl;
  List<String> tags;
  List<int> randomIntegers;
  List<double> randomDoubles;
  PersonalInfo personalInfo;

  Sample(
      {this.username,
      this.favouriteInteger,
      this.favouriteDouble,
      this.url,
      this.htmlUrl,
      this.tags,
      this.randomIntegers,
      this.randomDoubles,
      this.personalInfo});

  Sample.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    favouriteInteger = json['favouriteInteger'];
    favouriteDouble = json['favouriteDouble'];
    url = json['url'];
    htmlUrl = json['html_url'];
    tags = json['tags'].cast<String>();
    randomIntegers = json['randomIntegers'].cast<int>();
    randomDoubles = json['randomDoubles'].cast<double>();
    personalInfo = json['personalInfo'] != null
        ? PersonalInfo.fromJson(json['personalInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['favouriteInteger'] = favouriteInteger;
    data['favouriteDouble'] = favouriteDouble;
    data['url'] = url;
    data['html_url'] = htmlUrl;
    data['tags'] = tags;
    data['randomIntegers'] = randomIntegers;
    data['randomDoubles'] = randomDoubles;
    if (personalInfo != null) {
      data['personalInfo'] = personalInfo.toJson();
    }
    return data;
  }
}

class PersonalInfo {
  String firstName;
  String lastName;
  String location;
  List<Phones> phones;

  PersonalInfo({this.firstName, this.lastName, this.location, this.phones});

  PersonalInfo.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    location = json['location'];
    if (json['phones'] != null) {
      phones = <Phones>[];
      json['phones'].forEach((v) {
        phones.add(Phones.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['location'] = location;
    if (phones != null) {
      data['phones'] = phones.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Phones {
  String type;
  String number;
  bool shouldCall;

  Phones({this.type, this.number, this.shouldCall});

  Phones.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    number = json['number'];
    shouldCall = json['shouldCall'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['number'] = number;
    data['shouldCall'] = shouldCall;
    return data;
  }
}
