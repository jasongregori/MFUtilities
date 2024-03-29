//
//  MFKeychain.h
//
//  Created by Jason Gregori on 7/25/11.
//  Copyright 2011 Jason Gregori. All rights reserved.
//

// @mf: Easily and securely store whatever you want using the Keychain

/*
 
 Uses a keyed archiver to turn your object into data.
 Uses your key as the service and your bundle id as the account.
  
 */

#import <Foundation/Foundation.h>

@interface MFKeychain : NSObject

+ (BOOL)setObject:(id <NSCoding>)object withKey:(NSString *)key;
+ (id)objectForKey:(NSString *)key;

@end
