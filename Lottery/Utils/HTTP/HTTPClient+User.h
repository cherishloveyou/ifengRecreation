//
//  HTTPClient+User.h
//  Lottery
//
//  Created by August on 15/6/13.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "HTTPClient.h"
#import "HTTPConfigs.h"

typedef NS_ENUM(NSUInteger, UserHandlerAction) {
    UserHandlerActionLoginValidate = 1,
    UserHandlerActionCheckUsername,
    UserHandlerActionLogOut,
    UserHandlerActionBalance = 5, // 余额
    UserHandlerActionModifySafePassword = 7,
    UserHandlerActionLooteryRecord = 16
};

@interface HTTPClient (User)

+(void)userHandleWithAction:(UserHandlerAction)action
                 paramaters:(NSDictionary *)paramaters
                    success:(void(^)(id task, id response))success
                     failed:(void(^)(id task, NSError *error))failed;

@end
