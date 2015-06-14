//
//  HTTPConfigs.h
//  Lottery
//
//  Created by August on 15/6/13.
//  Copyright (c) 2015年 August. All rights reserved.
//

#ifndef Lottery_HTTPConfigs_h
#define Lottery_HTTPConfigs_h

#define HTTPBaseUrl @"http://58.96.185.182:8004/iphone/"

typedef NS_ENUM(NSUInteger, HTTPInterfaceType) {
    HTTPInterfaceTypeUserHandle
};

static NSString *const HTTPInterfaceTypePath[] = {
    [HTTPInterfaceTypeUserHandle] = @"UserHandler.ashx"
};

NS_INLINE NSString *getInterfaceUrlWithType(HTTPInterfaceType type){
    return [NSString stringWithFormat:@"%@%@",HTTPBaseUrl,HTTPInterfaceTypePath[type]];
}

#endif
