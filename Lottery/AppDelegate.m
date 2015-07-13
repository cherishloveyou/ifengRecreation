//
//  AppDelegate.m
//  Lottery
//
//  Created by August on 15/5/24.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "AppDelegate.h"
#import "Colours.h"

@interface AppDelegate ()

//hello

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self appearanceConfig];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

#pragma mark - private methods

-(void)appearanceConfig
{
    NSDictionary *navigationTitleAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:navigationTitleAttributes];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor fadedBlueColor]];
    
}

@end
