//
//  INetWorkingViewController.m
//  Instruments
//
//  Created by masonmei on 5/3/13.
//  Copyright (c) 2013 personal.org. All rights reserved.
//

#import "INetWorkingViewController.h"
#import "IReachability.h"

@interface INetWorkingViewController (){
    IReachability *reachability;
}

@end

@implementation INetWorkingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkNetworking:(id)sender {
    NSString *msgString = nil;
    if([IReachability isEnableWiFi]){
        msgString = [NSString stringWithFormat:@"Current NetWorking is %@", @"WIFI"];
    } else if([IReachability isEnableCarrierDataNetwork]){
        msgString = [NSString stringWithFormat:@"Current NetWorking is %@", @"CarrierDataNetwork"];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkingChange:) name:kReachabilityChangedNotification object:nil];
    
    [self showAlertWithTitle:@"Current Network" andMsg:msgString];
}

- (IBAction)startNotifyNetworkChange:(id)sender {
    reachability = [IReachability reachabilityForInternetConnection];
    [reachability startNotifier];
}

- (IBAction)stopNotifyNetworkChange:(id)sender {
    [reachability stopNotifier];
}

-(void) handleNetworkingChange:(NSNotification *)notification{
    IReachability *iReachability = [notification object];
    NSParameterAssert([iReachability isKindOfClass:[IReachability class]]);
    NetworkStatus status = [iReachability currentReachabilityStatus];
    NSString *msg = nil;
    switch (status) {
        case NotReachable:{
            msg = @"No Network!";
            break;
        }
        case ReachableViaWiFi:{
            msg = @"Via WiFi!";
            break;
        }
        case ReachableViaWWAN:{
            msg = @"Via WWAN!";
            break;
        }
    }
    
    [self showAlertWithTitle:@"Network Status" andMsg:msg];
}

-(void) showAlertWithTitle:(NSString *)title andMsg:(NSString *)msg{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"Got It" otherButtonTitles: nil];
    [alertView show];
}

@end
