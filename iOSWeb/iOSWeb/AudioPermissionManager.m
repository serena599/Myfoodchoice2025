#import "AudioPermissionManager.h"
#import <AVFoundation/AVFoundation.h>

@implementation AudioPermissionManager

+ (void)requestAudioPermission:(void (^)(BOOL granted))completion {
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    
    switch ([audioSession recordPermission]) {
        case AVAudioSessionRecordPermissionUndetermined: {
            [audioSession requestRecordPermission:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(granted);
                    }
                });
            }];
            break;
        }
        case AVAudioSessionRecordPermissionDenied: {
            NSLog(@"录音权限被拒绝");
            if (completion) {
                completion(NO);
            }
            // 可以在这里提示用户去设置中开启权限
            break;
        }
        case AVAudioSessionRecordPermissionGranted: {
            NSLog(@"已经获得录音权限");
            if (completion) {
                completion(YES);
            }
            break;
        }
    }
}

@end