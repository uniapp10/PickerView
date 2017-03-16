//
//  ViewController.m
//  DatePicker
//
//  Created by zhudong on 2017/3/16.
//  Copyright © 2017年 zhudong. All rights reserved.
//

#import "ViewController.h"
#import "GXDatePicker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnClick {
    GXDatePicker *datePickV = [[GXDatePicker alloc] init];
    [[UIApplication sharedApplication].keyWindow addSubview:datePickV];
}


@end
