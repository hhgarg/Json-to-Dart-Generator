import 'package:json_to_dart/json_to_dart.dart';

class Garg {
  Garg({this.jsonString, this.className = "Generated"});
  final String className;
  final String jsonString;
  String calc() {
    try {
      final dartCodeGenerator = ModelGenerator(className);
      final DartCode generatedCode =
          dartCodeGenerator.generateDartClasses(jsonString);

      return generatedCode.code;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
