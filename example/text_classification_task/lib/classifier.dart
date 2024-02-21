import 'package:tflite_flutter_processing/tflite_flutter_processing.dart';

abstract class Classifier {
  List<Category> classify(String text);
}
