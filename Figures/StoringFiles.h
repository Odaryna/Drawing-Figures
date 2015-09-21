//
//  StoringFiles.h
//  Figures
//
//  Created by Administrator on 9/21/15.
//  Copyright (c) 2015 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoringFiles : NSObject

@property (nonatomic,strong) NSString* nameOfThePlayer;

+ (StoringFiles*) SharedInstance;

@end
