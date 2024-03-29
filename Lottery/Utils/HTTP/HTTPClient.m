//
//  HTTPClient.m
//  Mindssage
//
//  Created by August on 14-9-23.
//
//

#import "HTTPClient.h"

NSString* const netWorkReachabilityDidChangedNotification = @"_netWorkReachabilityDidChangedNotification_";

@implementation HTTPClient

#define _SYSTERMVERSION_GREATER_7_0    [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

static AFHTTPRequestOperationManager *__operationManager = nil;
static AFHTTPSessionManager *__sessionManager = nil;

#pragma mark - BASE CONFIG

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_SYSTERMVERSION_GREATER_7_0) {
            __sessionManager = [AFHTTPSessionManager manager];
            __sessionManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
            __sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        }else{
            __operationManager = [AFHTTPRequestOperationManager manager];
            __operationManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
            __operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
        }
        AFNetworkReachabilityManager *reachablityManegetr = [AFNetworkReachabilityManager sharedManager];
        [reachablityManegetr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            [[NSNotificationCenter defaultCenter] postNotificationName:netWorkReachabilityDidChangedNotification object:@(status)];
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    _SYSTERMVERSION_GREATER_7_0 ? [__sessionManager.operationQueue setSuspended:YES]:[__operationManager.operationQueue setSuspended:YES];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    _SYSTERMVERSION_GREATER_7_0 ? [__sessionManager.operationQueue setSuspended:YES]:[__operationManager.operationQueue setSuspended:YES];
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    _SYSTERMVERSION_GREATER_7_0 ? [__sessionManager.operationQueue setSuspended:NO]:[__operationManager.operationQueue setSuspended:NO];
                    
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    _SYSTERMVERSION_GREATER_7_0 ? [__sessionManager.operationQueue setSuspended:NO]:[__operationManager.operationQueue setSuspended:NO];
                    break;
                    
                default:
                    _SYSTERMVERSION_GREATER_7_0 ? [__sessionManager.operationQueue setSuspended:YES]:[__operationManager.operationQueue setSuspended:YES];
                    break;
            }
        }];
        [reachablityManegetr startMonitoring];
    });
}

#pragma mark - request methods

+(id)get_RequestWithPath:(NSString *)path
              paramaters:(NSDictionary *)paramaters
                 success:(void (^)(id, id))success
                  failed:(void (^)(id, NSError *))failed
{
    
    if (_SYSTERMVERSION_GREATER_7_0) {
        return  [__sessionManager GET:path parameters:paramaters success:success failure:failed];
    }else{
        return [__operationManager GET:path parameters:paramaters success:success failure:failed];
    }
}

+(id)post_requestWithPath:(NSString *)path
               paramaters:(NSDictionary *)paramaters
                  success:(void (^)(id, id))success
                   failed:(void (^)(id, NSError *))failed
{
    if (_SYSTERMVERSION_GREATER_7_0) {
        return [__sessionManager POST:path parameters:paramaters success:success failure:failed];
    }else{
        return [__operationManager POST:path parameters:paramaters success:success failure:failed];
    }
}

+(id)post_requestWithPath:(NSString *)path
               paramaters:(NSDictionary *)paramaters
constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
                  success:(void (^)(id, id))success
                   failed:(void (^)(id, NSError *))failed
{
    if (_SYSTERMVERSION_GREATER_7_0) {
        return [__sessionManager POST:path
                           parameters:paramaters
            constructingBodyWithBlock:block
                              success:success
                              failure:failed];
    }else{
        return [__operationManager POST:path
                             parameters:paramaters
              constructingBodyWithBlock:block
                                success:success
                                failure:failed];
    }
}

+(id)put_requestwithPath:(NSString *)path
              paramaters:(NSDictionary *)paramaters
                    data:(NSData *)data
                 success:(void (^)(id, id))success
                  failed:(void (^)(id, NSError *))failed
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody:data];
    
    return [__operationManager HTTPRequestOperationWithRequest:request success:success failure:failed];
}

+(RACSignal *)get_RuquestWithPath:(NSString *)path paramaters:(NSDictionary *)paramaters
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        if (_SYSTERMVERSION_GREATER_7_0) {
            NSURLSessionDataTask *dataTask =  [__sessionManager GET:path
                                                         parameters:paramaters
                                                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                [subscriber sendNext:responseObject];
                                                            }
                                                            failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                [subscriber sendError:error];
                                                            }];
            return [RACDisposable disposableWithBlock:^{
                [dataTask cancel];
            }];
            
        }else{
            AFHTTPRequestOperation *requestOperation = [__operationManager GET:path
                                                                    parameters:nil
                                                                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                           [subscriber sendNext:responseObject];
                                                                       }
                                                                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                           [subscriber sendError:error];
                                                                       }];
            
            return [RACDisposable disposableWithBlock:^{
                [requestOperation cancel];
            }];
        }
        
    }];
    return signal;
}

+(RACSignal *)post_RequestWithPath:(NSString *)path paramaters:(NSDictionary *)paramaters
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        if (_SYSTERMVERSION_GREATER_7_0) {
            NSURLSessionDataTask *dataTask = [__sessionManager POST:path
                                                         parameters:paramaters
                                                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                [subscriber sendNext:responseObject];
                                                            }
                                                            failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                [subscriber sendError:error];
                                                            }];
            return [RACDisposable disposableWithBlock:^{
                [dataTask cancel];
            }];
        }else{
            AFHTTPRequestOperation *requestOpration = [__operationManager POST:path
                                                                    parameters:paramaters
                                                                       success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                           [subscriber sendNext:responseObject];
                                                                       }
                                                                       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                           [subscriber sendError:error];
                                                                       }];
            return [RACDisposable disposableWithBlock:^{
                [requestOpration cancel];
            }];
        }
    }];
    return signal;
}

+(RACSignal *)post_RequestWithPath:(NSString *)path
                        paramaters:(NSDictionary *)paramaters
         constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        if (_SYSTERMVERSION_GREATER_7_0) {
            NSURLSessionDataTask *dataTask = [__sessionManager POST:path
                                                         parameters:paramaters
                                          constructingBodyWithBlock:block
                                                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                                                [subscriber sendNext:responseObject];
                                                            }
                                                            failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                                [subscriber sendError:error];
                                                            }];
            return [RACDisposable disposableWithBlock:^{
                [dataTask cancel];
            }];
        }else{
            AFHTTPRequestOperation *requestOperation = [__operationManager POST:path
                                                                     parameters:paramaters
                                                      constructingBodyWithBlock:block
                                                                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                                            [subscriber sendNext:responseObject];
                                                                        }
                                                                        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                            [subscriber sendError:error];
                                                                        }];
            return [RACDisposable disposableWithBlock:^{
                [requestOperation cancel];
            }];
        }
    }];
}

@end