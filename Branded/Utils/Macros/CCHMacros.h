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
