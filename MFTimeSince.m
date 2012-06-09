//
//  MFTimeSince.m
//
//  Created by Jason Gregori on 9/15/11.
//  Copyright 2011 Jason Gregori. All rights reserved.
//

#import "MFTimeSince.h"

@interface __MFTimeSince_Format : NSObject
@property (nonatomic, copy) NSString *format;
@property (nonatomic, assign) NSTimeInterval upto;
@property (nonatomic, assign) NSTimeInterval secondsInUnit;
@end

@interface MFTimeSince ()
@property (nonatomic, strong) NSMutableArray *__formats;
@end

@implementation MFTimeSince
@synthesize __formats;

static MFTimeSince *__globalTimeSince = nil;
+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __globalTimeSince = [[MFTimeSince alloc] init];
    });
}

+ (void)setFormat:(NSString *)format forUpToThisManyUnits:(double)upto secondsInUnit:(NSUInteger)secondsInUnit {
    [__globalTimeSince setFormat:format forUpToThisManyUnits:upto secondsInUnit:secondsInUnit];
}

+ (NSString *)timeSince:(NSDate *)date {
    return [__globalTimeSince timeSince:date];
}

+ (NSString *)timeSinceTimestamp:(NSTimeInterval)timestamp {
    return [__globalTimeSince timeSinceTimestamp:timestamp];
}

- (id)init {
    self = [super init];
    if (self) {
        self.__formats = [NSMutableArray array];
    }
    return self;
}


- (void)setFormat:(NSString *)format forUpToThisManyUnits:(double)upto secondsInUnit:(NSUInteger)secondsInUnit {
    __MFTimeSince_Format *l = [[__MFTimeSince_Format alloc] init];
    l.format = format;
    l.upto = upto * (double)secondsInUnit;
    l.secondsInUnit = secondsInUnit;
    
    [self.__formats addObject:l];
    
    [self.__formats sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        if ([obj1 upto] < [obj2 upto]) {
            return NSOrderedAscending;
        }
        return NSOrderedDescending;
    }];
}

- (NSString *)timeSince:(NSDate *)date {
    return date ? [self timeSinceTimestamp:[date timeIntervalSince1970]] : nil;
}

- (NSString *)timeSinceTimestamp:(NSTimeInterval)timestamp {
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] - timestamp;
    if (interval < 0) {
        interval = 1;
    }
    
    for (__MFTimeSince_Format *l in self.__formats) {
        if (interval < l.upto) {
            return [NSString stringWithFormat:l.format, (int)(interval/l.secondsInUnit)];
        }
    }
    
    // if it didn't match use the last one
    __MFTimeSince_Format *l = [self.__formats lastObject];
    NSAssert(l, @"MFTimeSince: You have not set any format strings!");
    return [NSString stringWithFormat:l.format, (int)(interval/l.secondsInUnit)];
}

@end


@implementation __MFTimeSince_Format
@synthesize format, upto, secondsInUnit;

- (NSString *)description {
    return [NSString stringWithFormat:@"Upto %f seconds, \"%@\"", self.upto, self.format];
}


@end