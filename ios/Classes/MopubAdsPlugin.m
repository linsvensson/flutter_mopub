#import "MopubAdsPlugin.h"
#if __has_include(<mopub_ads/mopub_ads-Swift.h>)
#import <mopub_ads/mopub_ads-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "mopub_ads-Swift.h"
#endif

@implementation MopubAdsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMopubAdsPlugin registerWithRegistrar:registrar];
}
@end
