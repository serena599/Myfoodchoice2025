//
//  SceneDelegate.m
//  iOSWeb
//
//  Created by softlipa on 2024/11/15.
//

#import "SceneDelegate.h"
#import "AViewController.h"
#import "BViewController.h"
//#import "ExampleWKWebViewController.h"
#import "WebViewController.h"
#import "CustomTabBar.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    if ([scene isKindOfClass:[UIWindowScene class]]) {
        UIWindowScene *windowScene = (UIWindowScene *)scene;
        self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
        
        // 创建TabBarController
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
//        CustomTabBar *tab =[[CustomTabBar alloc] init];
//        [tabBarController setValue:tab forKey:@"tabBar"];

        // 创建两个视图控制器
        AViewController *controllerA = [[AViewController alloc] init];
        controllerA.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"主页"
                                                              image:[UIImage systemImageNamed:@"house"]
                                                      selectedImage:[UIImage systemImageNamed:@"house.fill"]];
        
        BViewController *controllerB = [BViewController new];
        controllerB.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"通话"
                                                              image:[UIImage systemImageNamed:@"phone"]
                                                      selectedImage:[UIImage systemImageNamed:@"phone.fill"]];

        // 设置TabBar的子控制器
        tabBarController.viewControllers = @[controllerA];
        
        // 设置window的根视图控制器
        self.window.rootViewController = tabBarController;
        [self.window makeKeyAndVisible];

        // 隐藏TabBar
        tabBarController.tabBar.hidden = YES;

        // 监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleCallNotification)
                                                     name:@"call"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleEndCallNotification)
                                                     name:@"endCall"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reset)
                                                     name:@"reset"
                                                   object:nil];
    }
}

// 处理"call"通知
- (void)handleCallNotification {
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    tabBarController.tabBar.hidden = NO; // 显示TabBar
    tabBarController.selectedIndex = 1; // 跳转到BViewController
}

// 处理"endCall"通知
- (void)handleEndCallNotification {
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    tabBarController.tabBar.hidden = YES; // 隐藏TabBar
}

- (void)reset {
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    tabBarController.tabBar.hidden = YES; // 隐藏TabBar
    tabBarController.selectedIndex = 0; // 跳转到BViewController
}

- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
