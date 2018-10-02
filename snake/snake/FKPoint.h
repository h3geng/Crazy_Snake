//
//  MyPoint.h
//  snake
//
//  Created by 耿华翼 on 16/11/14.
//  Copyright © 2016年 耿华翼. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FKPoint : NSObject

@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;

- (id) initWithX:(NSInteger) indexX indexY:(NSInteger) indexY;

- (bool) isEqual:(FKPoint *)object;


@end
