//
//  Copyright (c) Mendix, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridge.h>
#import "MendixApp.h"

@protocol ReactNativeDelegate;
@interface ReactNative: NSObject<RCTBridgeDelegate> {
  RCTBridge *bridge;
  UIWindow *rootWindow;
  UIWindow *appWindow;
  MendixApp *mendixApp;
  NSString *codePushKey;
}

@property(nonatomic, weak) id<ReactNativeDelegate> delegate;

+ (ReactNative *) instance;
+ (NSString *) warningsFilterToString:(WarningsFilter)warningsFilter;
- (void) start:(MendixApp*)mendixApp;
- (BOOL) isActive;
- (NSURL *) getJSBundleFile;
- (NSString *) getCodePushKey;
- (BOOL) userCodePush;
- (void) showAppMenu;
- (void) toggleElementInspector;
- (RCTBridge *) getBridge;
- (void) clearData;
- (void) clearCookies;
- (void) stop;
- (void) reload;
- (BOOL) isDebuggingRemotely;
- (void) remoteDebugging:(BOOL)enable;
- (void) setRemoteDebuggingPackagerPort:(NSInteger)port;

@end

@protocol ReactNativeDelegate
- (void) onAppClosed;
@end
