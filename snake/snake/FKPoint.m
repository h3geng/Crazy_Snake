//
//  MyPoint.m
//  snake
//
//  Created by 耿华翼 on 16/11/14.
//  Copyright © 2016年 耿华翼. All rights reserved.
//

#import "FKPoint.h"

@implementation FKPoint

- (id) initWithX:(NSInteger) indexX indexY:(NSInteger) indexY{
    self = [super init];
    if (self) {
        _x = indexX;
        _y = indexY;
    }
    return self;
}

- (bool) isEqual:(FKPoint *)object{
    if (self.x == object.x && self.y == object.y) {
        return YES;
    }else{
        return NO;
    }
}


@end
