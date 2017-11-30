//
//  AddressPickerView.h
//  AddressPicker
//
//  Created by Chan on 2017/10/30.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^complete)(NSString *provinceStr,NSString *cityStr);

@interface AddressPickerView : UIView

+ (AddressPickerView *)addressPickerViewWithComplete:(complete)complete;
@end
