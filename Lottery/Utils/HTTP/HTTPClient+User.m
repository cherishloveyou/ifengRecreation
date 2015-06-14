//
//  HTTPClient+User.m
//  Lottery
//
//  Created by August on 15/6/13.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "HTTPClient+User.h"

@implementation HTTPClient (User)

+(void)userHandleWithAction:(UserHandlerAction)action
                 paramaters:(NSDictionary *)paramaters
                    success:(void (^)(id, id))success
                     failed:(void (^)(id, NSError *))failed
{
    NSString *path = getInterfaceUrlWithType(HTTPInterfaceTypeUserHandle);
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:paramaters];
    [params setValue:@(action) forKey:@"action"];
    [HTTPClient post_requestWithPath:path
                          paramaters:params
                             success:^(id task, id response) {
                                 NSLog(@"response is %@",response);
                             } failed:^(id task, NSError *error) {
                                 NSLog(@"error is %@%@",error,task);
                             }];
}

@end
