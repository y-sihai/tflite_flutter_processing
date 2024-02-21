#import "TfliteFlutterProcessingPlugin.h"
#if __has_include(<tflite_flutter_processing/tflite_flutter_processing-Swift.h>)
#import <tflite_flutter_processing/tflite_flutter_processing-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "tflite_flutter_processing-Swift.h"
#endif

@implementation TfliteFlutterProcessingPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTfliteFlutterProcessingPlugin registerWithRegistrar:registrar];
}
@end
