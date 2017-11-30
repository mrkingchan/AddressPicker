//
//  ViewController.m
//  AddressPicker
//
//  Created by Chan on 2017/10/30.
//  Copyright © 2017年 Chan. All rights reserved.
//

#import "ViewController.h"
#import "ProvinceModel.h"
#import "NextVC.h"
#import <objc/runtime.h>

@interface ViewController () <UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray *_firstDataArray;
    NSMutableArray *_secondDataArray;
    NSMutableArray *_thirdDataArray;
    NSMutableArray *_fourthDataArray;
    
    UITableView *_firstTableView;
    UITableView *_secondTableView;
    UITableView *_thirdTableView;
    UITableView *_fourthTableView;
    
}

@end

@implementation ViewController

#pragma mark --LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    //访问UIpageControl的所有属性
    unsigned int count = 0;
    Ivar *vars = class_copyIvarList([UIPageControl  class], &count);
    for (int i = 0; i< count; i ++) {
        NSString *typeStr = [NSString stringWithUTF8String:ivar_getTypeEncoding(vars[i])];
        NSString *varKey = [NSString stringWithUTF8String:ivar_getName(vars[i])];
        NSLog(@"typeStr = %@----varName = %@\n",typeStr,varKey);
    }
    self.navigationItem.title = NSStringFromClass([self class]);
    _firstDataArray = [NSMutableArray new];
    _secondDataArray = [NSMutableArray new];
    _thirdDataArray = [NSMutableArray new];
    _fourthDataArray = [NSMutableArray new];
    
    CGFloat W = [UIScreen mainScreen].bounds.size.width / 4;
    CGFloat H = [UIScreen mainScreen].bounds.size.height ;
    _firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, W, H) style:UITableViewStylePlain];
    _firstTableView.dataSource = self;
    _firstTableView.delegate = self;
    [self.view addSubview:_firstTableView];
    
    _secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(W, 0, W, H) style:UITableViewStylePlain];
    _secondTableView.dataSource = self;
    _secondTableView.delegate = self;
    [self.view addSubview:_secondTableView];
    
    _thirdTableView = [[UITableView alloc] initWithFrame:CGRectMake(2 *W, 0, W, H) style:UITableViewStylePlain];
    _thirdTableView.dataSource = self;
    _thirdTableView.delegate = self;
    [self.view addSubview:_thirdTableView];
    
    _fourthTableView = [[UITableView alloc] initWithFrame:CGRectMake(3 *W, 0, W, H) style:UITableViewStylePlain];
    _fourthTableView.dataSource = self;
    _fourthTableView.delegate = self;
    [self.view addSubview:_fourthTableView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://apis.map.qq.com/ws/district/v1/list?key=K3VBZ-M6WWV-PPSPY-UVGGC-DRM2Z-PGBMV"]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil error:nil];
    if (data) {
        NSDictionary  *responseDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"reponse = %@",responseDic[@"result"][0]);
        for (NSDictionary *dic in responseDic[@"result"][0]) {
            ProvinceModel *model = [ProvinceModel new];
            [model setValuesForKeysWithDictionary:dic];
            [_firstDataArray addObject:model];
        }
        [_firstTableView reloadData];
    }
}

#pragma mark --UITableViewDataSource&Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:_firstTableView]) {
        return _firstDataArray.count;
    } else if ([tableView isEqual:_secondTableView]) {
        return _secondDataArray.count;
    } else if ([tableView isEqual:_thirdTableView]) {
        return _thirdDataArray.count;
    } else {
        return _fourthDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_firstTableView]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"first"];
        }
        ProvinceModel *model = _firstDataArray[indexPath.row];
        cell.textLabel.text = model.fullname;
        return cell;
    } else if ([tableView isEqual:_secondTableView]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"second"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"second"];
        }
        ProvinceModel *model = _secondDataArray[indexPath.row];
        cell.textLabel.text = model.fullname;
        return cell;
    } else if ([tableView isEqual:_thirdTableView]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"third"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"third"];
        }
        AreaModel *model = _thirdDataArray[indexPath.row];
        cell.textLabel.text = model.fullname;
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fourth"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fourth"];
        }
        AreaModel *model = _fourthDataArray[indexPath.row];
        cell.textLabel.text = model.fullname;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:_firstTableView]) {
        ProvinceModel *model = _firstDataArray[indexPath.row];
        NSString *urlString = [NSString stringWithFormat:@"http://apis.map.qq.com/ws/district/v1/getchildren?&id=%@&key=K3VBZ-M6WWV-PPSPY-UVGGC-DRM2Z-PGBMV", model.provinceId];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil error:nil];
        if (data) {
            NSDictionary  *responseDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"reponse = %@",responseDic[@"result"][0]);
            NSMutableArray *temArray = [NSMutableArray new];
            for (NSDictionary *dic in responseDic[@"result"][0]) {
                ProvinceModel *model = [ProvinceModel new];
                [model setValuesForKeysWithDictionary:dic];
                [temArray addObject:model];
            }
            _secondDataArray = temArray;
            [_secondTableView reloadData];
        }
    } else if ([tableView isEqual:_secondTableView]) {
        ProvinceModel *model = _secondDataArray[indexPath.row];
        NSString *urlString = [NSString stringWithFormat:@"http://apis.map.qq.com/ws/district/v1/getchildren?&id=%@&key=K3VBZ-M6WWV-PPSPY-UVGGC-DRM2Z-PGBMV", model.provinceId];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil error:nil];
        if (data) {
            NSDictionary  *responseDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"reponse = %@",responseDic[@"result"][0]);
            NSMutableArray *temArray = [NSMutableArray new];
            for (NSDictionary *dic in responseDic[@"result"][0]) {
                AreaModel *model = [AreaModel new];
                [model setValuesForKeysWithDictionary:dic];
                [temArray addObject:model];
            }
            _thirdDataArray = temArray;
            [_thirdTableView reloadData];
        }
    } else if ([tableView isEqual:_thirdTableView]) {
        AreaModel *model = _thirdDataArray[indexPath.row];
        NSString *urlString = [NSString stringWithFormat:@"http://apis.map.qq.com/ws/district/v1/getchildren?&id=%@&key=K3VBZ-M6WWV-PPSPY-UVGGC-DRM2Z-PGBMV", model.areaId];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil error:nil];
        if (data) {
            NSDictionary  *responseDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"reponse = %@",responseDic[@"result"][0]);
            NSMutableArray *temArray = [NSMutableArray new];
            for (NSDictionary *dic in responseDic[@"result"][0]) {
                AreaModel *model = [AreaModel new];
                [model setValuesForKeysWithDictionary:dic];
                [temArray addObject:model];
            }
            _fourthDataArray = temArray;
            [_fourthTableView reloadData];
        }
    } else if ([tableView isEqual:_fourthTableView]) {
        NextVC *VC = [NextVC new];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

@end

