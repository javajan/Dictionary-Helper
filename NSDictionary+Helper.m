//
//  NSDictionary+Helper.m
//  YouTube v3
//
//  Created by Jan-Philipp Hampe on 23.04.14.
//  Copyright (c) 2014 Jan-Philipp Hampe. All rights reserved.
//

#import "NSDictionary+Helper.h"

@implementation NSDictionary (Helper)

// object is in this format: contentDetails.social(6).resourceId.channelId
- (id)findObject:(NSString *)object
{
    NSArray *parts = [object componentsSeparatedByString:@"."];
    NSDictionary *curDict = self;
    
    for (int i = 0; i < parts.count; i++) {
        NSString *key = [parts objectAtIndex:i];
        
        if ([self string:key contains:@"("]) {
            int index = [self findArrayIndexIn:key];
            key = [self removeArrayNumberIn:key];
            
            if (i < parts.count - 1) {
                curDict = [[curDict objectForKey:key] objectAtIndex:index];
            }
            else {
                return [[curDict objectForKey:key] objectAtIndex:index];
            }
        }
        else if (i < parts.count - 1) {
            curDict = [curDict objectForKey:key];
        }
        else {
            return [curDict objectForKey:key];
        }
    }
    
    return nil;
}

- (BOOL)string:(NSString *)string contains:(NSString *)search
{
    if ([string rangeOfString:search].location != NSNotFound)
    {
        return YES;
    }
    return NO;
}

- (int)findArrayIndexIn:(NSString *)string
{
    NSString *index;
    NSRange start = [string rangeOfString:@"("];
    if (start.location != NSNotFound)
    {
        index = [string substringFromIndex:start.location + start.length];
        NSRange end = [index rangeOfString:@")"];
        if (end.location != NSNotFound)
        {
            index = [index substringToIndex:end.location];
        }
    }
    
    return [index intValue];
}

- (NSString *)removeArrayNumberIn:(NSString *)string
{
    NSRange rangeOfOpenBracket = [string rangeOfString:@"("];
    if (rangeOfOpenBracket.location != NSNotFound) {
        return [string substringToIndex:rangeOfOpenBracket.location];
    }
    else {
        return string;
    }
}

@end
