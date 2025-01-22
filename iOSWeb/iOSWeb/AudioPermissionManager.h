#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioPermissionManager : NSObject

/**
 请求音频录制权限
 
 @param completion 完成回调，BOOL 参数表示是否获得权限
 */
+ (void)requestAudioPermission:(void (^)(BOOL granted))completion;

@end

NS_ASSUME_NONNULL_END