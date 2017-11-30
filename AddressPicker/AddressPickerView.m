//
//  AddressPickerView.m
//  AddressPicker
//
//  Created by Chan on 2017/10/30.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import "AddressPickerView.h"

@interface AddressPickerView() <UIPickerViewDelegate,UIPickerViewDataSource>{
    UIPickerView *_provincePicker;
    UIPickerView*_cityPicker;
    NSArray  *_dataArray;
    NSArray *_data;
    complete _complete;
    NSString *_provinceStr;
    NSString *_areaStr;
}

@end

@implementation AddressPickerView

+ (AddressPickerView *)addressPickerViewWithComplete:(complete)complete {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ProvincesAndCities" ofType:@"plist"];
    NSArray *temArray = [NSArray arrayWithContentsOfFile:path];
    return [AddressPickerView addressPickerViewWithDataArray:temArray
                                          WithDataArray2:nil
                                                 provinceStr:@""
                                                 areaStr:@""
                                                    Complete:complete];
}

+ (AddressPickerView *)addressPickerViewWithDataArray:(NSArray *)dataArray
                                       WithDataArray2:(NSArray *)dataArray2
                                          provinceStr:(NSString *)provinceStr
                                              areaStr:(NSString *)areaStr
                                             Complete:(complete)complete {
    return [[AddressPickerView alloc] initWithDataArray:dataArray
                                         WithDataArray2:dataArray2
                                            provinceStr:provinceStr
                                                areaStr:areaStr
                                               Complete:complete];
}

- (AddressPickerView *)initWithDataArray:(NSArray *)dataArray
                             WithDataArray2:(NSArray *)dataArray2
                             provinceStr:(NSString *)provinceStr
                                 areaStr:(NSString *)areaStr
                                Complete:(complete)complete {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        _dataArray = dataArray;
        _complete = complete;
        _provinceStr = provinceStr;
        _areaStr = areaStr;
        _data = dataArray2;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [self setUI];
    }
    return self;
}

- (void)setUI {
    _provincePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 200, [UIScreen mainScreen].bounds.size.width/2, 200)];
    _provincePicker.backgroundColor = [UIColor whiteColor];
    _provincePicker.delegate = self;
    _provincePicker.dataSource = self;
    [self addSubview:_provincePicker];
    
    _cityPicker = [[UIPickerView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height - 200, [UIScreen mainScreen].bounds.size.width / 2, 200)];
    _cityPicker.dataSource = self;
    _cityPicker.backgroundColor = [UIColor whiteColor];
    _cityPicker.delegate = self;
    [self addSubview:_cityPicker];
    [self addSubview:_cityPicker];
    _data = _dataArray[0][@"Cities"];
    [_cityPicker reloadAllComponents];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual:_provincePicker]) {
        return _dataArray.count;
    } else if ([pickerView isEqual:_cityPicker]) {
        //获取所选取的row
        NSInteger selectedRow = [_provincePicker  selectedRowInComponent:0];
        return [_dataArray[selectedRow][@"Cities"] count];
//        return _data.count;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([pickerView  isEqual:_provincePicker]) {
        return  _dataArray[row][@"State"];
    } else  if ([pickerView isEqual:_cityPicker])  {
        return _data[row][@"city"];
    }
    return  @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    puts(__func__);
    if ([pickerView isEqual:_provincePicker]) {
        _provinceStr = _dataArray[row][@"State"];
        _data = _dataArray[row][@"Cities"];
        [_cityPicker reloadAllComponents];
    } else if ([pickerView isEqual:_cityPicker]) {
        _areaStr = _dataArray[row][@"city"];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
    if (_complete) {
        _complete(_provinceStr,_areaStr);
    }
}

@end
