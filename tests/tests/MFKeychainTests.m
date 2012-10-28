//
//  MFKeychainTests.m
//  tests
//
//  Created by Jason Gregori on 10/27/12.
//  Copyright (c) 2012 Jason Gregori. All rights reserved.
//

#import "MFKeychainTests.h"

#import "MFKeychain.h"

@implementation MFKeychainTests

- (void)testSimpleSetAndGet {
    NSString *key = @"password", *secret = @"swordfish";
    [MFKeychain setObject:secret withKey:key];
    STAssertEqualObjects(secret, [MFKeychain objectForKey:key], nil);
}

- (void)testComplicatedSetAndGet {
    NSString *key = @"stuff";
    id stuff = @[ @NO, @"string", @12345, @{ @1 : @"asdf", @"a" : @YES } ];
    [MFKeychain setObject:stuff withKey:key];
    STAssertEqualObjects(stuff, [MFKeychain objectForKey:key], nil);
}

@end
