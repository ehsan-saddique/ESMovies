//
//  ViewController.m
//  Vodworks
//
//  Created by Ehsan Saddique on 30/12/2016.
//  Copyright © 2016 Ehsan. All rights reserved.
//

#import "ViewController.h"
#import "ServiceManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[ServiceManager sharedManager] startGETRequestWithURL:@"http://192.168.8.104:3003/getShowcase" andParameters:nil userInfo:nil withSuccessCallback:^(id responseObject) {
        
        NSLog(@"final response >> %@", responseObject);
        
    } andFailureCallBack:^(NSError *error) {
        NSLog(@"final failed >> %@", error.localizedDescription);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
