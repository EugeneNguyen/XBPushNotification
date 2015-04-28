//
//  XBPushNotification.h
//  Pods
//
//  Created by Binh Nguyen Xuan on 4/28/15.
//
//

#import <Foundation/Foundation.h>

@interface XBPushNotification : NSObject

+ (void)registerPush;
+ (void)completeWithToken:(NSData *)_deviceToken;
+ (NSString *)deviceToken;

@end
