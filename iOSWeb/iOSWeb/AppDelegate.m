//
//  AppDelegate.m
//  iOSWeb
//
//  Created by softlipa on 2024/11/15.
//

#import "AppDelegate.h"
#import "AViewController.h"
#import "BViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    
//    // 创建TabBarController
//    UITabBarController *tabBarController = [[UITabBarController alloc] init];
//    
//    // 创建两个视图控制器
//    AViewController *controllerA = [[AViewController alloc] init];
//    controllerA.title = @"A页面";
//    controllerA.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"A页面" 
//                                                          image:[UIImage systemImageNamed:@"house"]
//                                                  selectedImage:[UIImage systemImageNamed:@"house.fill"]];
//    
//    BViewController *controllerB = [[BViewController alloc] init];
//    controllerB.title = @"B页面";
//    controllerB.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"B页面"
//                                                          image:[UIImage systemImageNamed:@"person"]
//                                                  selectedImage:[UIImage systemImageNamed:@"person.fill"]];
//    
//    // 设置TabBar的子控制器
//    tabBarController.viewControllers = @[controllerA, controllerB];
//    
//    // 设置window的根视图控制器
//    self.window.rootViewController = tabBarController;
//    [self.window makeKeyAndVisible];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
