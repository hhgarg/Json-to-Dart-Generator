class BugTen {
  Glossary glossary;

  BugTen({this.glossary});

  BugTen.fromJson(Map<String, dynamic> json) {
    glossary = json['glossary'] != null
        ? Glossary.fromJson(json['glossary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (glossary != null) {
      data['glossary'] = glossary.toJson();
    }
    return data;
  }
}

class Glossary {
  String title;
  GlossDiv glossDiv;

  Glossary({this.title, this.glossDiv});

  Glossary.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    glossDiv = json['GlossDiv'] != null
        ? GlossDiv.fromJson(json['GlossDiv'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (glossDiv != null) {
      data['GlossDiv'] = glossDiv.toJson();
    }
    return data;
  }
}

class GlossDiv {
  String title;
  GlossList glossList;

  GlossDiv({this.title, this.glossList});

  GlossDiv.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    glossList = json['GlossList'] != null
        ? GlossList.fromJson(json['GlossList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (glossList != null) {
      data['GlossList'] = glossList.toJson();
    }
    return data;
  }
}

class GlossList {
  GlossEntry glossEntry;

  GlossList({this.glossEntry});

  GlossList.fromJson(Map<String, dynamic> json) {
    glossEntry = json['GlossEntry'] != null
        ? GlossEntry.fromJson(json['GlossEntry'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (glossEntry != null) {
      data['GlossEntry'] = glossEntry.toJson();
    }
    return data;
  }
}

class GlossEntry {
  String iD;
  String sortAs;
  String glossTerm;
  String acronym;
  String abbrev;
  GlossDef glossDef;
  String glossSee;

  GlossEntry(
      {this.iD,
      this.sortAs,
      this.glossTerm,
      this.acronym,
      this.abbrev,
      this.glossDef,
      this.glossSee});

  GlossEntry.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    sortAs = json['SortAs'];
    glossTerm = json['GlossTerm'];
    acronym = json['Acronym'];
    abbrev = json['Abbrev'];
    glossDef = json['GlossDef'] != null
        ? GlossDef.fromJson(json['GlossDef'])
        : null;
    glossSee = json['GlossSee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['SortAs'] = sortAs;
    data['GlossTerm'] = glossTerm;
    data['Acronym'] = acronym;
    data['Abbrev'] = abbrev;
    if (glossDef != null) {
      data['GlossDef'] = glossDef.toJson();
    }
    data['GlossSee'] = glossSee;
    return data;
  }
}

class GlossDef {
  String para;
  List<String> glossSeeAlso;

  GlossDef({this.para, this.glossSeeAlso});

  GlossDef.fromJson(Map<String, dynamic> json) {
    para = json['para'];
    glossSeeAlso = json['GlossSeeAlso'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['para'] = para;
    data['GlossSeeAlso'] = glossSeeAlso;
    return data;
  }
}
