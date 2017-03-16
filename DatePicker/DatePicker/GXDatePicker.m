//
//  GXDatePicker.m
//  GXAppNew
//
//  Created by zhudong on 2017/3/13.
//  Copyright © 2017年 futang yang. All rights reserved.
//

#import "GXDatePicker.h"
#import "Masonry.h"
#import "NSDateFormatter+GXDateFormatter.h"
#import "GXHoldTool.h"
#define GXScreenWidth [UIScreen mainScreen].bounds.size.width

@interface GXDatePicker ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic,strong) NSArray<NSMutableArray*> *dataSource;
@property (nonatomic,assign) NSInteger firstRowCount;
@property (nonatomic,assign) NSInteger secondRowCount;
@property (nonatomic,strong) NSArray *daysArray;
@property (nonatomic,copy) NSString *seletedMonthStr;
@property (nonatomic,strong) UIPickerView *pickV;

@end
@implementation GXDatePicker

- (instancetype)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [okBtn setTitle:@"确定" forState:UIControlStateNormal];
        okBtn.backgroundColor = [UIColor grayColor];
        [self addSubview:okBtn];
        [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(@0);
            make.height.equalTo(@44);
        }];
        okBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [okBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.firstRowCount = 15;
        self.secondRowCount = 15;
        UIPickerView *pickV = [[UIPickerView alloc] init];
        self.pickV = pickV;
        pickV.backgroundColor = [UIColor whiteColor];
        pickV.dataSource = self;
        pickV.delegate = self;
        [self addSubview:pickV];
        [pickV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(@0);
            make.height.equalTo(@150);
            make.bottom.equalTo(okBtn.mas_top);
        }];

        UIView *topV = [[UIView alloc] init];
        topV.backgroundColor = [UIColor grayColor];
        UILabel *leftL = [GXHoldTool labelWithWeight:1 font:16 text:@"开始日期" textColor:[UIColor blueColor]];
        leftL.textAlignment = NSTextAlignmentCenter;
        UILabel *rightL = [GXHoldTool labelWithWeight:1 font:16 text:@"结束日期" textColor:[UIColor blueColor]];
        rightL.textAlignment = NSTextAlignmentCenter;
        [topV addSubview:leftL];
        [topV addSubview:rightL];
        [leftL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.left.equalTo(@0);
            make.width.equalTo(@(GXScreenWidth / 2));
        }];
        [rightL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.right.equalTo(@0);
            make.width.equalTo(@(GXScreenWidth / 2));
        }];
        [self addSubview:topV];
        [topV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.equalTo(@40);
            make.bottom.equalTo(pickV.mas_top);
        }];
        [pickV selectRow:(self.dataSource.firstObject.count - 2) inComponent:0 animated:true];
        [pickV selectRow:0 inComponent:1 animated:true];
        [pickV selectRow:(self.dataSource.lastObject.count - 1) inComponent:2 animated:true];
        [pickV selectRow:(self.secondRowCount - 1) inComponent:3 animated:true];
    }
    return self;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger row;
    if (component == 0) {
        row = self.dataSource.firstObject.count;
    }else if(component == 1){
        row = self.firstRowCount;
    }else if(component == 2){
        row = self.dataSource.lastObject.count;
    }else if(component == 3){
        row = self.secondRowCount;
    }
    return row;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}
#pragma mark - UIPickerViewDelegate
//- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    return self.dataSource[component][row];
//}
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
////    if (component == 0 || component == 2) {
////        return (GXScreenWidth / 4) * 1.5;
////    }
////    return (GXScreenWidth / 4) * 0.5;
//    return GXScreenWidth / 2;
////    return (GXScreenWidth / 4);
//}
//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
//    return 50;
//}
//- (CGSize)rowSizeForComponent:(NSInteger)component{
//    if (component == 0 || component == 2) {
//        return CGSizeMake((GXScreenWidth / 4) * 1.5, 20);
//    }
//    return CGSizeMake((GXScreenWidth / 4) * 1.5, 20);
//}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
    UILabel *label = [[UILabel alloc] init];
//    if (component == 0 || component == 2) {
//        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (GXScreenWidth / 2) * 1.5, 20)];
////        label.backgroundColor = [UIColor redColor];
//    }else{
//        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (GXScreenWidth / 2) * 0.5, 20)];
////        label.backgroundColor = [UIColor greenColor];
//    }
    NSString *title;
    if (component == 0) {
        title = self.dataSource.firstObject[row];
    }else if(component == 1 || component == 3){
        title = self.daysArray[row];
        NSString *str = [NSString stringWithFormat:@"%@%@", self.seletedMonthStr, title];
        //        GXLog(@"%@", str);
        NSDateFormatter *dateF = [NSDateFormatter shareFormatter];
        dateF.dateFormat = @"yyyy年MM月dd日";
        NSDate *date = [dateF dateFromString:str];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        if ([calendar isDateInToday:date]) {
            title = @"今天";
        }
    }else if(component == 2){
        title = self.dataSource.lastObject[row];
        self.seletedMonthStr = title;
    }
    
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    return label;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        NSArray *monthArr = self.dataSource[0];
        NSString *monthStr = monthArr[row];
        self.seletedMonthStr = monthStr;
        self.firstRowCount = [self daysCount:monthStr];
        if (row == monthArr.count - 1) {
            NSCalendar *calendar = [NSCalendar currentCalendar];
            self.firstRowCount = [calendar component:NSCalendarUnitDay fromDate:[NSDate date]];
        }
        [pickerView reloadComponent:1];
    }
    else if (component == 2){
        NSArray *monthArr = self.dataSource[1];
        NSString *monthStr = monthArr[row];
        self.seletedMonthStr = monthStr;
        self.secondRowCount = [self daysCount:monthStr];
        if (row == monthArr.count - 1) {
            NSCalendar *calendar = [NSCalendar currentCalendar];
            self.secondRowCount = [calendar component:NSCalendarUnitDay fromDate:[NSDate date]];
        }
        [pickerView reloadComponent:3];
    }
}

- (NSInteger)daysCount: (NSString *)dateStr{
    NSDateFormatter *dateF = [NSDateFormatter shareFormatter];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    dateF.dateFormat = @"yyyy年MM月";
    NSDate *date = [dateF dateFromString:dateStr];
    NSRange days = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return days.length;
}

- (void)okBtnClick{
    NSInteger first = [self.pickV selectedRowInComponent:0];
    NSInteger second = [self.pickV selectedRowInComponent:1];
    NSInteger third = [self.pickV selectedRowInComponent:2];
    NSInteger forth = [self.pickV selectedRowInComponent:3];
    NSString *beginDateStr = [NSString stringWithFormat:@"%@%@", self.dataSource.firstObject[first], self.daysArray[second]];
    NSString *endDateStr = [NSString stringWithFormat:@"%@%@", self.dataSource.firstObject[third], self.daysArray[forth]];
    NSDateFormatter *dateF = [NSDateFormatter shareFormatter];
    dateF.dateFormat = @"yyyy年MM月dd日";
    NSDate *beginDate = [dateF dateFromString:beginDateStr];
    NSDate *endDate = [dateF dateFromString:endDateStr];
    NSTimeInterval dateInterval = [beginDate timeIntervalSinceDate:endDate];
    if (dateInterval >= 0) {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"开始日期不能大于结束日期,请您重新选择" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertV show];
    }
    
}

-(NSArray *)dataSource{
    if (!_dataSource) {
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:2];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSInteger year = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
        NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:[NSDate date]];
        NSMutableArray *arrMOne = [NSMutableArray arrayWithCapacity:13];
        year = year - 1;
        for (int j = 0; j < 13; j++) {
            if (month > 12) {
                month = 1;
                year += 1;
            }
            NSString *dateOne = [NSString stringWithFormat:@"%zd年%02zd月",year, month];
            [arrMOne addObject:dateOne];
            month++;
        }
        [arrM addObject:arrMOne];
        [arrM addObject:arrMOne.copy];
        
        _dataSource = arrM;
    }
    
    return _dataSource;
}

- (NSArray *)daysArray{
    if (!_daysArray) {
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:31];
        for (int i = 0; i < 31; i++) {
            NSString *dayStr = [NSString stringWithFormat:@"%02zd日", i+1];
            [arrM addObject:dayStr];
        }
        _daysArray = arrM;
    }
    return _daysArray;
}
@end
