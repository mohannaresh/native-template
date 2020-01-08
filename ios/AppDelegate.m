#import <Firebase.h>
#import "AppDelegate.h"
#import "MendixNative/MendixNative.h"
#import "RNFirebase/RNFirebaseNotifications.h"
#import "RNFirebase/RNFirebaseMessaging.h"

@implementation AppDelegate

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  if ([ReactNative.instance useFirebase]) {
    [FIRApp configure];
    [RNFirebaseNotifications configure];
  }

  NSBundle *mainBundle = [NSBundle mainBundle];
  NSString *targetName = [mainBundle objectForInfoDictionaryKey:@"TargetName"] ?: @"";

  if ([targetName  isEqual: @"dev"]) {
    return YES;
  }

  NSString *url = [mainBundle objectForInfoDictionaryKey:@"Runtime url"];
  if (url == nil) {
    [NSException raise:@"RuntimeURLMissing" format:@"Missing the 'Runtime url' configuration within the Info.plist file"];
  }
  NSURL *runtimeUrl = [AppUrl forRuntime:[url stringByReplacingOccurrencesOfString:@"\\" withString:@""]];
  NSURL *bundleUrl = [ReactNative.instance getJSBundleFile];
  
  [ReactNative.instance start:[[MendixApp alloc] init:nil bundleUrl:bundleUrl runtimeUrl:runtimeUrl warningsFilter:none enableGestures:false clearDataAtLaunch:false reactLoadingStoryboard:nil]];
  
  return YES;
}

- (void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
  if ([ReactNative.instance useFirebase]) {
    [[RNFirebaseNotifications instance] didReceiveLocalNotification:notification];
  }
}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo
fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler{
  if ([ReactNative.instance useFirebase]) {
    [[RNFirebaseNotifications instance] didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
  }
}

- (void) application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
  if ([ReactNative.instance useFirebase]) {
    [[RNFirebaseMessaging instance] didRegisterUserNotificationSettings:notificationSettings];
  }
}

@end
