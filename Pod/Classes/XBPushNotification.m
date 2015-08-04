//
//  XBPushNotification.m
//  Pods
//
//  Created by Binh Nguyen Xuan on 4/28/15.
//
//

#import "XBPushNotification.h"
#import "XBCacheRequest.h"

@implementation XBPushNotification

+ (void)registerPush
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
}

+ (void)updateToService
{
    XBCacheRequest *request = XBCacheRequest(@"pushplus/handle_add_device");
    request.dataPost = [@{@"owner_id": @-1,
                          @"devicetype": @"ios",
                          @"deviceid": [XBPushNotification deviceToken]} mutableCopy];
    [request startAsynchronousWithCallback:^(XBCacheRequest *request, NSString *result, BOOL fromCache, NSError *error, id object) {
        
    }];
}

+ (void)completeWithToken:(NSData *)_deviceToken
{
    NSString * deviceToken = [[[[_deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""] stringByReplacingOccurrencesOfString: @">" withString: @""] stringByReplacingOccurrencesOfString: @" " withString: @""];
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:@"XBPushNotificationDeviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"XBPushNotificationDeviceTokenChange" object:nil];
    [XBPushNotification updateToService];
}

+ (NSString *)deviceToken
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"XBPushNotificationDeviceToken"];
}

@end
