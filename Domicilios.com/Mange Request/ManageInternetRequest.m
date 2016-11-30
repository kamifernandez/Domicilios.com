//
//  ManageInternetRequest.m
//  Leal
//
//  Created by KUBO on 1/6/16.
//  Copyright © 2016 KUBO. All rights reserved.
//

#import "ManageInternetRequest.h"
#import "UrlConstructor.h"

@implementation ManageInternetRequest

#pragma mark Organizer Request

+(NSMutableArray *)organizer:(NSString *)description data:(NSMutableDictionary *)data{
    NSMutableArray *stringDictio = nil;
    NSURLResponse *response;
    NSError *error;
    NSString *urlString = @"";
    if ([description isEqualToString:@"data"]) {
        urlString = [UrlConstructor userList];
    }
    
    NSMutableURLRequest *request =
    [NSMutableURLRequest requestWithURL:[NSURL
                                         URLWithString:urlString]
                            cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                        timeoutInterval:10
     ];
    
    NSData * temp = [self sendSynchronousRequest:request returningResponse:&response error:&error];
    if (temp) {
        NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:temp
                                                                   options:kNilOptions error:&error];
        if (!error) {
            stringDictio = (NSMutableArray *)dictionary;
        }
    }
    return stringDictio;
}


#pragma mark AsynchronousRequest Internet

+ (NSData *)sendSynchronousRequest:(NSURLRequest *)request
                 returningResponse:(__autoreleasing NSURLResponse **)responsePtr
                             error:(__autoreleasing NSError **)errorPtr {
    dispatch_semaphore_t    sem;
    __block NSData *        result;
    
    result = nil;
    
    sem = dispatch_semaphore_create(0);
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request
                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                         if (errorPtr != NULL) {
                                             *errorPtr = error;
                                         }
                                         if (responsePtr != NULL) {
                                             *responsePtr = response;
                                         }
                                         if (error == nil) {
                                             result = data;
                                         }
                                         dispatch_semaphore_signal(sem);
                                     }] resume];
    
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    
    return result;
}

@end
