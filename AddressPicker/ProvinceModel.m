//
//  ProvinceModel.m
//  AddressPicker
//
//  Created by Chan on 2017/10/31.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import "ProvinceModel.h"

@implementation ProvinceModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if([key isEqualToString:@"id"])  {
        self.provinceId = value;
    }
}

@end

@implementation AreaModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if([key isEqualToString:@"id"])  {
        self.areaId = value;
    }
}
@end


