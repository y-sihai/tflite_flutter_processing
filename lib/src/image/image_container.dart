import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_processing/src/image/base_image_container.dart';
import 'package:tflite_flutter_processing/src/image/image_conversions.dart';
import 'package:tflite_flutter_processing/src/tensorbuffer/tensorbuffer.dart';
import 'package:tflite_flutter_processing/src/image/color_space_type.dart';

class ImageContainer extends BaseImageContainer {
  late final img.Image _image;

  ImageContainer._(img.Image image) {
    this._image = image;
  }

  static ImageContainer create(img.Image image) {
    return ImageContainer._(image);
  }

  @override
  BaseImageContainer clone() {
    return create(_image.clone());
  }

  @override
  ColorSpaceType get colorSpaceType {
    if (image.numChannels == 1) {
      return ColorSpaceType.GRAYSCALE;
    } else {
      return ColorSpaceType.RGB;
    }
  }

  @override
  TensorBuffer getTensorBuffer(TensorType dataType) {
    TensorBuffer buffer = TensorBuffer.createDynamic(dataType);
    ImageConversions.convertImageToTensorBuffer(image, buffer);
    return buffer;
  }

  @override
  int get height => _image.height;

  @override
  img.Image get image => _image;

  @override
  CameraImage get mediaImage => throw UnsupportedError(
      'Converting from Image to CameraImage is unsupported');

  @override
  int get width => _image.width;
}
