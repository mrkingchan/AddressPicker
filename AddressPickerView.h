//
//  AddressPickerView.h
//  KKJob
//
//  Created by Jason on 2019/2/1.
//  Copyright © 2019年 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressPickerView : UIView

@property(nonatomic,copy) void (^complete)(NSString *province,NSString *city,NSString *subCity,NSString *street);

+ (instancetype)addressPickerViewWithComplete:(void (^)(NSString *province,NSString *city,NSString *subCity,NSString *street))complete;

@end

NS_ASSUME_NONNULL_END
