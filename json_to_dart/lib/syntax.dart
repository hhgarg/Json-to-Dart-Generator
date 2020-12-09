import 'package:json_ast/json_ast.dart' show Node;
import 'package:json_to_dart/helpers.dart';

const String emptyListWarn = 'list is empty';
const String ambiguousListWarn = 'list is ambiguous';
const String ambiguousTypeWarn = 'type is ambiguous';

class Warning {
  final String warning;
  final String path;

  Warning(this.warning, this.path);
}

Warning newEmptyListWarn(String path) {
  return Warning(emptyListWarn, path);
}

Warning newAmbiguousListWarn(String path) {
  return Warning(ambiguousListWarn, path);
}

Warning newAmbiguousType(String path) {
  return Warning(ambiguousTypeWarn, path);
}

class WithWarning<T> {
  final T result;
  final List<Warning> warnings;

  WithWarning(this.result, this.warnings);
}

class TypeDefinition {
  String name;
  String subtype;
  bool isAmbiguous = false;
  bool _isPrimitive = false;

  factory TypeDefinition.fromDynamic(dynamic obj, Node astNode) {
    bool isAmbiguous = false;
    final type = getTypeName(obj);
    if (type == 'List') {
      List<dynamic> list = obj;
      String elemType;
      if (list.isNotEmpty) {
        elemType = getTypeName(list[0]);
        for (dynamic listVal in list) {
          if (elemType != getTypeName(listVal)) {
            isAmbiguous = true;
            break;
          }
        }
      } else {
        // when array is empty insert Null just to warn the user
        elemType = 'Null';
      }
      return TypeDefinition(type,
          astNode: astNode, subtype: elemType, isAmbiguous: isAmbiguous);
    }
    return TypeDefinition(type, astNode: astNode, isAmbiguous: isAmbiguous);
  }

  TypeDefinition(this.name, {this.subtype, this.isAmbiguous, Node astNode}) {
    if (subtype == null) {
      _isPrimitive = isPrimitiveType(name);
      if (name == 'int' && isASTLiteralDouble(astNode)) {
        name = 'double';
      }
    } else {
      _isPrimitive = isPrimitiveType('$name<$subtype>');
    }
    isAmbiguous ??= false;
  }

  @override
  bool operator ==(other) {
    if (other is TypeDefinition) {
      TypeDefinition otherTypeDef = other;
      return name == otherTypeDef.name &&
          subtype == otherTypeDef.subtype &&
          isAmbiguous == otherTypeDef.isAmbiguous &&
          _isPrimitive == otherTypeDef._isPrimitive;
    }
    return false;
  }

  bool get isPrimitive => _isPrimitive;

  bool get isPrimitiveList => _isPrimitive && name == 'List';

  String _buildParseClass(String expression, bool newKeyword) {
    final properType = subtype ?? name;
    if (newKeyword) {
      return 'new $properType.fromJson($expression)';
    } else {
      return '$properType.fromJson($expression)';
    }
  }

  String _buildToJsonClass(String expression) {
    return '$expression.toJson()';
  }

  String jsonParseExpression(
    String key,
    bool privateField,
    bool newKeyword,
    bool thisKeyword,
    bool collectonLiteral,
  ) {
    final jsonKey = "json['$key']";
    String fieldKey =
        fixFieldName(key, typeDef: this, privateField: privateField);
    if (thisKeyword) {
      fieldKey = 'this.' + fieldKey;
    }
    if (isPrimitive) {
      if (name == 'List') {
        return "$fieldKey = json['$key'].cast<$subtype>();";
      }
      return "$fieldKey = json['$key'];";
    } else if (name == 'List' && subtype == 'DateTime') {
      return "$fieldKey = json['$key'].map((v) => DateTime.tryParse(v));";
    } else if (name == 'DateTime') {
      return "$fieldKey = DateTime.tryParse(json['$key']);";
    } else if (name == 'List') {
      // list of class
      if (collectonLiteral) {
        return "if (json['$key'] != null) {\n\t\t\t$fieldKey = <$subtype>[];\n\t\t\tjson['$key'].forEach((v) { $fieldKey.add($subtype.fromJson(v)); });\n\t\t}";
      } else {
        if (newKeyword) {
          return "if (json['$key'] != null) {\n\t\t\t$fieldKey = new List<$subtype>();\n\t\t\tjson['$key'].forEach((v) { $fieldKey.add(new $subtype.fromJson(v)); });\n\t\t}";
        } else {
          return "if (json['$key'] != null) {\n\t\t\t$fieldKey = List<$subtype>();\n\t\t\tjson['$key'].forEach((v) { $fieldKey.add($subtype.fromJson(v)); });\n\t\t}";
        }
      }
    } else {
      // class
      return "$fieldKey = json['$key'] != null ? ${_buildParseClass(jsonKey, newKeyword)} : null;";
    }
  }

  String jsonParseExpressionFinal(
    String key,
    bool privateField,
    bool newKeyword,
    bool thisKeyword,
    bool collectonLiteral,
  ) {
    final jsonKey = "json['$key']";
    String fieldKey =
        fixFieldName(key, typeDef: this, privateField: privateField);
    if (isPrimitive) {
      if (name == 'List') {
        return "$fieldKey : json['$key'].cast<$subtype>(),";
      }
      return "$fieldKey : json['$key'],";
    } else if (name == 'List' && subtype == 'DateTime') {
      return "$fieldKey : json['$key'].map((v) => DateTime.tryParse(v)),";
    } else if (name == 'DateTime') {
      return "$fieldKey : DateTime.tryParse(json['$key']),";
    } else if (name == 'List') {
      // list of class
      if (newKeyword) {
        return "$fieldKey : json['$key'] != null ? List<$subtype>.from(json['$key'].map((x) => new $subtype.fromJson(x))) : null,";
      } else {
        return "$fieldKey : json['$key'] != null ? List<$subtype>.from(json['$key'].map((x) => $subtype.fromJson(x))) : null,";
      }
    } else {
      // class
      return "$fieldKey : json['$key'] != null ? ${_buildParseClass(jsonKey, newKeyword)} : null,";
    }
  }

  String toJsonExpression(String key, bool privateField, bool thisKeyword) {
    final fieldKey =
        fixFieldName(key, typeDef: this, privateField: privateField);
    String thisKey = '$fieldKey';
    if (thisKeyword) {
      thisKey = 'this.$fieldKey';
    }
    if (isPrimitive) {
      return "data['$key'] = $thisKey;";
    } else if (name == 'List') {
      // class list
      return """if ($thisKey != null) {
      data['$key'] = $thisKey.map((v) => ${_buildToJsonClass('v')}).toList();
    }""";
    } else {
      // class
      return """if ($thisKey != null) {
      data['$key'] = ${_buildToJsonClass(thisKey)};
    }""";
    }
  }
}

class Dependency {
  String name;
  final TypeDefinition typeDef;

  Dependency(this.name, this.typeDef);

  String get className => camelCase(name);
}

class ClassDefinition {
  final String _name;
  final bool _privateFields;
  final bool _newKeyword;
  final bool _thisKeyword;
  final bool _collectionLiterals;
  final bool _makePropertiesRequired;
  final bool _makePropertiesFinal;
  final bool _typesOnly;
  final Map<String, TypeDefinition> fields = <String, TypeDefinition>{};

  String get name => _name;
  bool get privateFields => _privateFields;
  bool get newKeyword => _newKeyword;
  bool get thisKeyword => _thisKeyword;
  bool get collectionLiterals => _collectionLiterals;
  bool get makePropertiesRequired => _makePropertiesRequired;
  bool get makePropertiesFinal => _makePropertiesFinal;
  bool get typesOnly => _typesOnly;
  List<Dependency> get dependencies {
    final dependenciesList = <Dependency>[];
    final keys = fields.keys;
    keys.forEach((k) {
      final f = fields[k];
      if (!f.isPrimitive) {
        dependenciesList.add(Dependency(k, f));
      }
    });
    return dependenciesList;
  }

  ClassDefinition(
    this._name, [
    this._privateFields = false,
    this._newKeyword = false,
    this._thisKeyword = false,
    this._collectionLiterals = true,
    this._makePropertiesRequired = false,
    this._makePropertiesFinal = false,
    this._typesOnly = false,
  ]);

  @override
  bool operator ==(other) {
    if (other is ClassDefinition) {
      ClassDefinition otherClassDef = other;
      return isSubsetOf(otherClassDef) && otherClassDef.isSubsetOf(this);
    }
    return false;
  }

  bool isSubsetOf(ClassDefinition other) {
    final List<String> keys = fields.keys.toList();
    final int len = keys.length;
    for (int i = 0; i < len; i++) {
      TypeDefinition otherTypeDef = other.fields[keys[i]];
      if (otherTypeDef != null) {
        TypeDefinition typeDef = fields[keys[i]];
        if (typeDef != otherTypeDef) {
          return false;
        }
      } else {
        return false;
      }
    }
    return true;
  }

  dynamic hasField(TypeDefinition otherField) {
    return fields.keys
            .firstWhere((k) => fields[k] == otherField, orElse: () => null) !=
        null;
  }

  dynamic addField(String name, TypeDefinition typeDef) {
    fields[name] = typeDef;
  }

  void _addTypeDef(TypeDefinition typeDef, StringBuffer sb) {
    sb.write('${typeDef.name}');
    if (typeDef.subtype != null) {
      sb.write('<${typeDef.subtype}>');
    }
  }

  String get _fieldList {
    return fields.keys.map((key) {
      final f = fields[key];
      final fieldName =
          fixFieldName(key, typeDef: f, privateField: privateFields);
      final sb = StringBuffer();
      sb.write('\t');
      if (makePropertiesFinal) {
        sb.write('final ');
      }
      _addTypeDef(f, sb);
      sb.write(' $fieldName;');
      return sb.toString();
    }).join('\n');
  }

  String get _gettersSetters {
    return fields.keys.map((key) {
      final f = fields[key];
      final publicFieldName =
          fixFieldName(key, typeDef: f, privateField: false);
      final privateFieldName =
          fixFieldName(key, typeDef: f, privateField: true);
      final sb = StringBuffer();
      sb.write('\t');
      _addTypeDef(f, sb);
      sb.write(
          ' get $publicFieldName => $privateFieldName;\n\tset $publicFieldName(');
      _addTypeDef(f, sb);
      sb.write(' $publicFieldName) => $privateFieldName = $publicFieldName;');
      return sb.toString();
    }).join('\n');
  }

  String get _defaultPrivateConstructor {
    final sb = StringBuffer();
    sb.write('\t$name({');
    var i = 0;
    var len = fields.keys.length - 1;
    fields.keys.forEach((key) {
      final f = fields[key];
      final publicFieldName =
          fixFieldName(key, typeDef: f, privateField: false);
      if (makePropertiesRequired) {
        sb.write('@required ');
      }
      _addTypeDef(f, sb);
      sb.write(' $publicFieldName');
      if (i != len) {
        sb.write(', ');
      }
      i++;
    });
    sb.write('}) {\n');
    fields.keys.forEach((key) {
      final f = fields[key];
      final publicFieldName =
          fixFieldName(key, typeDef: f, privateField: false);
      final privateFieldName =
          fixFieldName(key, typeDef: f, privateField: true);
      sb.write('this.$privateFieldName = $publicFieldName;\n');
    });
    sb.write('}');
    return sb.toString();
  }

  String get _defaultConstructor {
    final sb = StringBuffer();
    sb.write('\t$name({');
    var i = 0;
    var len = fields.keys.length - 1;
    fields.keys.forEach((key) {
      final f = fields[key];
      final fieldName =
          fixFieldName(key, typeDef: f, privateField: privateFields);
      if (makePropertiesRequired) {
        sb.write('@required this.$fieldName');
      } else {
        sb.write('this.$fieldName');
      }

      if (i != len) {
        sb.write(', ');
      }
      i++;
    });
    sb.write('});');
    return sb.toString();
  }

  String get _jsonParseFunc {
    final sb = StringBuffer();
    if (makePropertiesFinal) {
      sb.write('\tfactory $name');
      sb.write('.fromJson(Map<String, dynamic> json) {\n');
      sb.write('\treturn $name(\n');
      // sb.write('.fromJson(Map<String, dynamic> json) => $name(\n');
      fields.keys.forEach((k) {
        sb.write(
            '\t\t${fields[k].jsonParseExpressionFinal(k, privateFields, newKeyword, thisKeyword, collectionLiterals)}\n');
      });
      sb.write('\t);');
      sb.write('}');
      return sb.toString();
    } else {
      sb.write('\t$name');
      sb.write('.fromJson(Map<String, dynamic> json) {\n');
      fields.keys.forEach((k) {
        sb.write(
            '\t\t${fields[k].jsonParseExpression(k, privateFields, newKeyword, thisKeyword, collectionLiterals)}\n');
      });
      sb.write('\t}');
      return sb.toString();
    }
  }

  String get _jsonGenFunc {
    final sb = StringBuffer();
    if (collectionLiterals) {
      sb.write(
          '\tMap<String, dynamic> toJson() {\n\t\tfinal Map<String, dynamic> data = <String, dynamic>{};\n');
    } else {
      if (newKeyword) {
        sb.write(
            '\tMap<String, dynamic> toJson() {\n\t\tfinal Map<String, dynamic> data = new Map<String, dynamic>();\n');
      } else {
        sb.write(
            '\tMap<String, dynamic> toJson() {\n\t\tfinal Map<String, dynamic> data = Map<String, dynamic>();\n');
      }
    }
    fields.keys.forEach((k) {
      sb.write(
          '\t\t${fields[k].toJsonExpression(k, privateFields, thisKeyword)}\n');
    });
    sb.write('\t\treturn data;\n');
    sb.write('\t}');
    return sb.toString();
  }

  @override
  String toString() {
    if (typesOnly) {
      if (privateFields) {
        return 'class $name {\n$_fieldList\n\n$_defaultPrivateConstructor\n\n$_gettersSetters\n}\n';
      } else {
        return 'class $name {\n$_fieldList\n\n$_defaultConstructor\n}\n';
      }
    } else {
      if (privateFields) {
        return 'class $name {\n$_fieldList\n\n$_defaultPrivateConstructor\n\n$_gettersSetters\n\n$_jsonParseFunc\n\n$_jsonGenFunc\n}\n';
      } else {
        return 'class $name {\n$_fieldList\n\n$_defaultConstructor\n\n$_jsonParseFunc\n\n$_jsonGenFunc\n}\n';
      }
    }
  }
}
