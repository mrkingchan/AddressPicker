//
//  NextVC.m
//  AddressPicker
//
//  Created by Chan on 2017/10/31.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import "NextVC.h"

#import "AddressPickerView.h"

@interface NextVC () {
}
@end

@implementation NextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [AddressPickerView addressPickerViewWithComplete:^(NSString *provinceStr, NSString *cityStr) {
        NSLog(@"provinceStr = %@---areaStr = %@",provinceStr,cityStr);
    }];
}
@end
