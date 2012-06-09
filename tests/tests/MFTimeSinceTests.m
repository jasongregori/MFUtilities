//
//  MFTimeSinceTests.m
//  tests
//
//  Created by Jason Gregori on 6/8/12.
//  Copyright (c) 2012 Jason Gregori. All rights reserved.
//

#import "MFTimeSinceTests.h"
#import "MFTimeSince.h"

@implementation MFTimeSinceTests {
    MFTimeSince *_example;
}


- (void)setUp {
    // a good example
    _example = [MFTimeSince new];
    [_example setFormat:@"now" forUpToThisManyUnits:5 secondsInUnit:60]; // up to 5 minutes
    [_example setFormat:@"%i minutes" forUpToThisManyUnits:60 secondsInUnit:60]; // up to 60 minutes
    [_example setFormat:@"1 hour" forUpToThisManyUnits:2 secondsInUnit:60*60]; // up to (but not including) 2 hours
    [_example setFormat:@"%i hours" forUpToThisManyUnits:24 secondsInUnit:60*60]; // up to 24 hours
    [_example setFormat:@"1 day" forUpToThisManyUnits:2 secondsInUnit:24*60*60]; // up to (but not including) 2 days
    [_example setFormat:@"%i days" forUpToThisManyUnits:DBL_MAX secondsInUnit:24*60*60]; // goes forever
}


- (void)testGlobal {
    NSString *string = @"recently";
    [MFTimeSince setFormat:string forUpToThisManyUnits:FLT_MAX secondsInUnit:1];
    STAssertEqualObjects([MFTimeSince timeSince:[NSDate date]], string, nil);
}

- (void)testReturnsCorrectString {
    STAssertEqualObjects([_example timeSince:[NSDate date]], @"now", nil);
}

- (void)testAccuratelySplits {
    // time since should stop returning now at exactly 5 minutes
    NSDate *fiveMinutesAgo = [[NSDate date] dateByAddingTimeInterval:-5*60];
    STAssertFalse([[_example timeSince:fiveMinutesAgo] isEqual:@"now"], nil);
}

- (void)testGivesAccurateCount {
    NSDate *fortyMinutesAgo = [[NSDate date] dateByAddingTimeInterval:-40*60];
    STAssertEqualObjects([_example timeSince:fortyMinutesAgo], @"40 minutes", nil);
}

@end
