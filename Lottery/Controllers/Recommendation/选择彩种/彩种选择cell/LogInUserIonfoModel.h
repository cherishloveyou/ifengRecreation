//
//  LogInUserIonfoModel.h
//  Lottery
//
//  Created by 刘继洋 on 15/7/5.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LoginUserType) {
    
    LoginUserTypeNone = 0,//无类型
    
    LoginUserrTypeProxy = 1,//代理用户
    
    LoginUserrTypeAverage//普通用户
    
};


@interface LogInUserIonfoModel : NSObject

/**
 *  用户名
 */
@property (nonatomic,strong) NSString *userName;
/**
 *  用户id
 */
@property (nonatomic,strong) NSString *userId;
/**
 *  唯一登录标示符
 */
@property (nonatomic,strong) NSString *loginFlag;

@property (nonatomic,strong) NSString *userMoney;
/**
 *  用户类型
 */
@property (nonatomic,assign) LoginUserType userType;

/**
 *  默认单利方法
 *
 *  @param userInfo 登录返回的用户信息字典
 *
 *  @return loginUserInfo对象
 */
+ (instancetype)defaultUserInfo;

+ (instancetype)defaultUserInfoWithUserInfo:(NSDictionary*)userInfo;

- (instancetype)initWithUserInfo:(NSDictionary*)userInfo;

+ (NSString*)userName;

+ (NSString*)userId;

+ (NSString*)loginFlag;

+ (NSString*)UserMoney;

+ (LoginUserType)userType;


@end
