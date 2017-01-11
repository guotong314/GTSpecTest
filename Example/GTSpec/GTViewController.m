//
//  GTViewController.m
//  GTSpec
//
//  Created by 郭通 on 12/27/2016.
//  Copyright (c) 2016 郭通. All rights reserved.
//

#import "GTViewController.h"
#import "GTURLHelper.h"
@interface GTViewController ()

@end

@implementation GTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    KLSwitch *sw = [[KLSwitch alloc] init];
//    [self.view addSubview:sw];
    NSString *url = @"dm://tokenInValid?uid=1111&shop=2222";
    GTURLHelper *helper = [GTURLHelper URLWithString:url];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
