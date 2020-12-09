import 'package:json_to_dart/json_to_dart.dart';

class Garg {
  Garg({this.jsonString});
  final String jsonString;
  String calc() {
    final dartCodeGenerator = ModelGenerator('Sample');
    final DartCode generatedCode =
        dartCodeGenerator.generateDartClasses(jsonString);

    return generatedCode.code;
  }
}
