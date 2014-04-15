//
//  CCHMacros.h
//  Branded
//
//  Created by PAWAN POUDEL on 4/15/14.
//  Copyright (c) 2014 Pawan Poudel. All rights reserved.
//

#define SuppressPerformSelectorLeakWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
    } while (0)


static inline BOOL IsEmpty(id thing) {
    return thing == nil
    || ([thing isEqual:[NSNull null]]) //JS addition for things like coredata
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

static inline BOOL IsNotEmpty(id thing) {
    if (IsEmpty(thing)) {
        return NO;
    }
    
    return YES;
}