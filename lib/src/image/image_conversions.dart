import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_processing/src/image/color_space_type.dart';
import 'package:tflite_flutter_processing/src/tensorbuffer/tensorbuffer.dart';

/// Implements some stateless image conversion methods.
///
/// This class is an internal helper.
class ImageConversions {
  static img.Image convertRgbTensorBufferToImage(TensorBuffer buffer) {
    List<int> shape = buffer.getShape();
    ColorSpaceType rgb = ColorSpaceType.RGB;
    rgb.assertShape(shape);

    int h = rgb.getHeight(shape);
    int w = rgb.getWidth(shape);
    img.Image image = img.Image(width: w, height: h);

    List<int> rgbValues = buffer.getIntList();
    assert(rgbValues.length == w * h * 3);

    for (int i = 0, j = 0, wi = 0, hi = 0; j < rgbValues.length; i++) {
      int r = rgbValues[j++];
      int g = rgbValues[j++];
      int b = rgbValues[j++];
      image.setPixelRgba(wi, hi, r, g, b, 1);
      wi++;
      if (wi % w == 0) {
        wi = 0;
        hi++;
      }
    }

    return image;
  }

  static img.Image convertGrayscaleTensorBufferToImage(TensorBuffer buffer) {
    // Convert buffer into Uint8 as needed.
    TensorBuffer uint8Buffer = buffer.getDataType() == TfLiteType.kTfLiteUInt8
        ? buffer
        : TensorBuffer.createFrom(buffer, TfLiteType.kTfLiteUInt8);

    final shape = uint8Buffer.getShape();
    final grayscale = ColorSpaceType.GRAYSCALE;
    grayscale.assertShape(shape);

    final image = img.Image.fromBytes(width:grayscale.getWidth(shape),
        height:grayscale.getHeight(shape), bytes: uint8Buffer.getBuffer(),
        format: img.Format.uint8);

    return image;
  }

  static void convertImageToTensorBuffer(img.Image image, TensorBuffer buffer) {
    int w = image.width;
    int h = image.height;
    List<img.Pixel>? pixels = image.data?.toList();
    int flatSize = w * h * 3;
    List<int> shape = [h, w, 3];
    switch (buffer.getDataType()) {
      case TfLiteType.kTfLiteUInt8:
        List<int> byteArr = List.filled(flatSize, 0);
        for (int i = 0, j = 0; i < pixels!.length; i++) {
          byteArr[j++] = pixels[i].r.toInt();
          byteArr[j++] = pixels[i].g.toInt();
          byteArr[j++] = pixels[i].b.toInt();
        }
        buffer.loadList(byteArr, shape: shape);
        break;
      case TfLiteType.kTfLiteFloat32:
        List<double> floatArr = List.filled(flatSize, 0.0);
        for (int i = 0, j = 0; i < pixels!.length; i++) {
          floatArr[j++] = pixels[i].r.toDouble();
          floatArr[j++] = pixels[i].r.toDouble();
          floatArr[j++] = pixels[i].r.toDouble();
        }
        buffer.loadList(floatArr, shape: shape);
        break;
      default:
        throw StateError(
            "${buffer.getDataType()} is unsupported with TensorBuffer.");
    }
  }
}
