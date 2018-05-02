//
//  NSException+DBR.m
//  DesktopBrowser
//
//  Created by Jeffrey Bergier on 29/04/2018.
//  Copyright © 2018 Jeffrey Bergier. All rights reserved.
//

#import "NSException+DBR.h"

@implementation NSException (DBR)

+ (void)throwIfNilObject:(id __nullable)object;
{
    if (object) { return; }
    @throw [[NSException alloc] initWithName:@"DBR_assertObjectNotNIL"
                                      reason:@"Expected Object to be Non-NIL"
                                    userInfo:nil];
}

+ (void)throwIfNSNotFound:(NSInteger)value;
{
    if (value == NSNotFound) {
        @throw [[NSException alloc] initWithName:@"DBR_assertValueNotNSNotFound"
                                          reason:@"Expected Value to NOT be NSNotFound"
                                        userInfo:nil];
    } else {
        return;
    }
}
@end
