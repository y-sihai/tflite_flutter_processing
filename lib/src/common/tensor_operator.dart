import 'package:tflite_flutter_processing/src/common/operator.dart';
import 'package:tflite_flutter_processing/src/tensorbuffer/tensorbuffer.dart';

/// Applies some operation on TensorBuffers.
abstract class TensorOperator extends Operator<TensorBuffer> {
  /// See [Operator.apply].
  @override
  TensorBuffer apply(TensorBuffer input);
}
