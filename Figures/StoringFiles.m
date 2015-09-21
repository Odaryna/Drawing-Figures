//
//  StoringFiles.m
//  Figures
//
//  Created by Administrator on 9/21/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import "StoringFiles.h"

@implementation StoringFiles

+ (StoringFiles*) SharedInstance
{
    static StoringFiles *ob;
    static dispatch_once_t predicat;
    
    dispatch_once(&predicat, ^{
        ob = [[StoringFiles alloc]init];
    });
    
    return ob;
}

@end
