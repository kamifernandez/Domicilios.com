//
//  UrlConstructor.m
//  Linker
//
//  Created by KUBO on 11/25/15.
//  Copyright © 2015 KUBO. All rights reserved.
//

#import "UrlConstructor.h"

static NSString *domain = @"https://api.myjson.com/bins/1zib8";

@implementation UrlConstructor

+(NSString *)userList{
    
    NSString *url = [NSString stringWithFormat:@"%@",domain];
    
    NSLog(@"%@",url);
    
    return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
