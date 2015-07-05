//
//  LogInUserIonfoModel.m
//  Lottery
//
//  Created by 刘继洋 on 15/7/5.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "LogInUserIonfoModel.h"
#import "Macros.h"

@implementation LogInUserIonfoModel

static LogInUserIonfoModel *sharedAccountManagerInstance;

/**
 *  默认单利方法
 *
 *  @param userInfo 登录返回的用户信息字典
 *
 *  @return loginUserInfo对象
 */
+ (instancetype)defaultUserInfoWithUserInfo:(NSDictionary*)userInfo{
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[LogInUserIonfoModel alloc] init];
        if (userInfo) {
            
            sharedAccountManagerInstance.userName = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"userName"]];
            sharedAccountManagerInstance.userId = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"userId"]];
            sharedAccountManagerInstance.loginFlag = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"flag"]];
            NSInteger userType = [[userInfo objectForKey:@"userType"] integerValue];
            switch (userType) {
                case 1:
                    sharedAccountManagerInstance.userType = LoginUserrTypeProxy;
                    break;
                case 2:
                    sharedAccountManagerInstance.userType = LoginUserrTypeAverage;
                    break;
                default:
                    break;
            }
        }
        
    });
    return sharedAccountManagerInstance;
}

+ (instancetype)defaultUserInfo{
    
    if (!sharedAccountManagerInstance) {
        sharedAccountManagerInstance = [[LogInUserIonfoModel alloc] init];
    }
    
    return sharedAccountManagerInstance;
}



- (instancetype)initWithUserInfo:(NSDictionary *)userInfo{
    self = [super init];
    if (self && userInfo) {
        self.userName = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"userName"]];
        self.userId = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"userId"]];
        self.loginFlag = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"flag"]];
        NSInteger userType = [[userInfo objectForKey:@"userType"] integerValue];
        switch (userType) {
            case 1:
                self.userType = LoginUserrTypeProxy;
                break;
            case 2:
                self.userType = LoginUserrTypeAverage;
                break;
            default:
                break;
        }
    }
    return self;
}

- (NSString *)userName{
    if (!_userName) {
        _userName = [NSString stringWithFormat:@"%@",[uerdictionary objectForKey:@"userName"]];
    }
    return _userName;
}

- (NSString *)userId{
    if (!_userId) {
        _userId = [NSString stringWithFormat:@"%@",[uerdictionary objectForKey:@"userId"]];
    }
    return _userId;
}

- (NSString *)loginFlag{
    
    if (!_loginFlag) {
        _loginFlag = [NSString stringWithFormat:@"%@",[uerdictionary objectForKey:@"flag"]];
    }
    
    return _loginFlag;
}

- (LoginUserType)userType{
    
    if (!_userType) {
        NSInteger userType = [[uerdictionary objectForKey:@"userType"] integerValue];
        switch (userType) {
            case 1:
                self.userType = LoginUserrTypeProxy;
                break;
            case 2:
                self.userType = LoginUserrTypeAverage;
                break;
            default:
                break;
        }
    }
    
    return _userType;
}

+ (NSString*)userName{
    if (!sharedAccountManagerInstance) {
        sharedAccountManagerInstance = [[LogInUserIonfoModel alloc] init];
    }
    
    return sharedAccountManagerInstance.userName;
}

+ (NSString*)userId{
    if (!sharedAccountManagerInstance) {
        sharedAccountManagerInstance = [[LogInUserIonfoModel alloc] init];
    }
    return sharedAccountManagerInstance.userId;
}

+ (NSString*)loginFlag{
    if (!sharedAccountManagerInstance) {
        sharedAccountManagerInstance = [[LogInUserIonfoModel alloc] init];
    }
    return sharedAccountManagerInstance.loginFlag;
}

+ (LoginUserType)userType{
    if (!sharedAccountManagerInstance) {
        sharedAccountManagerInstance = [[LogInUserIonfoModel alloc] init];
    }
    return sharedAccountManagerInstance.userType;
}



@end
