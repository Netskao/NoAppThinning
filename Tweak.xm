/* Source: https://gist.github.com/level3tjg/813f7269a405b00203484382da18d3bf */
/* Credits: level3tjg */

#import <UIKit/UIKit.h>

static NSString *const kDeviceType = @"iPhone";

%hook XDCDevice
- (NSString *)productType {
    return kDeviceType;
}
%end

%hook Device
- (NSArray<NSString *> *)productVariants {
    return @[kDeviceType];
}
%end

%hook SSDevice
- (NSString *)productType {
    return kDeviceType;
}
- (NSString *)compatibleProductType {
    return kDeviceType;
}
%end

%hook AMSDevice
+ (NSString *)productType {
    return kDeviceType;
}
+ (NSString *)compatibleProductType {
    return kDeviceType;
}
+ (NSString *)_lib_compatibleProductType {
    return kDeviceType;
}
%end

// TestFlight Hooks
static BOOL isRequestNewApp = NO;

%hook TFCurrentDevice
+ (NSArray<NSString *> *)compatibleAppVariants {
    if (isRequestNewApp) return %orig;
    return @[kDeviceType];
}
%end

// Flag to add a new application request
%hook TFHallidayService
- (void)requestAppForPublicLinkToken:(id)arg1 completion:(void (^)(id response, id error))completion {
    isRequestNewApp = YES;
    completion = ^(id response, id error) {
    if (!error) {
    isRequestNewApp = NO;
    }
    completion(response, error);
    };
    return %orig;
}

- (void)postAcceptPublicLinkWithToken:(id)arg1 completion:(void (^)(id response, id error))completion {
    isRequestNewApp = YES;
    completion = ^(id response, id error) {
    if (!error) {
    isRequestNewApp = NO;
    }
    completion(response, error);
    };
    return %orig;
}
%end
