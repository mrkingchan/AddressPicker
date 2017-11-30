//
//  ProvinceModel.h
//  AddressPicker
//
//  Created by Chan on 2017/10/31.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceModel : NSObject

@property(nonatomic,strong) NSString *fullname;

@property(nonatomic,strong) NSString *name;

@property(nonatomic,strong) NSString *provinceId;

@property(nonatomic,strong) NSDictionary *location;

@property(nonatomic,strong) NSArray *cidx;

@property(nonatomic,strong) NSArray *pinyin;

@end

@interface AreaModel:NSObject

@property(nonatomic,strong) NSString *fullname;

@property(nonatomic,strong) NSString *areaId;

@property(nonatomic,strong) NSDictionary *location;


@end
