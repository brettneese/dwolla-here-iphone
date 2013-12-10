//
//  SettingsViewController.m
//  DwollaV2
//
//  Created by Nick Schulze on 2/22/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//
#import "ProgressHUD.h"
#import "SettingsViewController.h"
#import <GeotriggerSDK/GeotriggerSDK.h>

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize nav;
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        screenBounds = [[UIScreen mainScreen] bounds];
        self.view.frame = CGRectMake(0, screenBounds.size.height, 320, screenBounds.size.height - 56);
        
        self.view.backgroundColor = [UIColor DwollaGray];
        
        top = [[RoundedView alloc] initWithFrame:CGRectMake(10, 50, 300, 190)];
        [top setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:top];
        
        middle = [[UIView alloc] initWithFrame:CGRectMake(10, 250, 300, 500)];
        [middle setBackgroundColor:[UIColor DwollaGray]];
        [self.view addSubview:middle];

        profile = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        [top addSubview:profile];
        
        name = [[BoldTextView alloc] initWithFrame:CGRectMake(65, 15, 200, 40)];
        [top addSubview:name];
        
        _id = [[UITextView alloc] initWithFrame:CGRectMake(65, 35, 100, 35)];
        [_id setUserInteractionEnabled:NO];
        [_id setTextColor:[UIColor DwollaDarkGray]];
        [_id setFont:[UIFont fontWithName:@"GillSans" size:12]];
        [_id setBackgroundColor:[UIColor clearColor]];
        [_id setText:@""];
        [top addSubview:_id];
        

        
        transactionsb = [[UIButton alloc] initWithFrame:CGRectMake(10, 80, 280, 50)];
        [transactionsb setBackgroundImage:[UIImage imageNamed:@"dw_transaction.png"] forState:UIControlStateNormal];
        [transactionsb setTitleColor:[UIColor DwollaDarkGray] forState:UIControlStateNormal];
        transactionsb.titleLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:14];
        [transactionsb setTitle:@"Transaction History" forState:UIControlStateNormal];
        [transactionsb addTarget:self action:@selector(showTransactions) forControlEvents:UIControlEventTouchUpInside];
        [top addSubview:transactionsb];
        
        requestsb = [[UIButton alloc] initWithFrame:CGRectMake(10, 135, 280, 50)];
        [requestsb setBackgroundImage:[UIImage imageNamed:@"dw_transaction.png"] forState:UIControlStateNormal];
        [requestsb setTitleColor:[UIColor DwollaDarkGray] forState:UIControlStateNormal];
        requestsb.titleLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:14];
        [requestsb setTitle:@"Requests" forState:UIControlStateNormal];
        [requestsb addTarget:self action:@selector(loadRequests) forControlEvents:UIControlEventTouchUpInside];
        [top addSubview:requestsb];
        
        
        push_enable = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 39)];
        [push_enable setBackgroundColor:[UIColor clearColor]];
        [push_enable setBackgroundImage:[UIImage imageNamed:@"dw_sourcet.png"] forState:UIControlStateNormal];
        [push_enable setTitleColor:[UIColor DwollaDarkGray] forState:UIControlStateNormal];
        push_enable.titleLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:14];
        [push_enable setTitle:@"Enable Push Notifications" forState:UIControlStateNormal];
        [push_enable addTarget:self action:@selector(enablePush) forControlEvents:UIControlEventTouchUpInside];
        push_enable.hidden = YES;
        [middle addSubview:push_enable];
        
        push_disable = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 300, 39)];
        [push_disable setBackgroundColor:[UIColor clearColor]];
        [push_disable setBackgroundImage:[UIImage imageNamed:@"dw_sourcet.png"] forState:UIControlStateNormal];
        [push_disable setTitleColor:[UIColor DwollaDarkGray] forState:UIControlStateNormal];
        push_disable.titleLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:14];
        [push_disable setTitle:@"Disable Push Notifications" forState:UIControlStateNormal];
        [push_disable addTarget:self action:@selector(disablePush) forControlEvents:UIControlEventTouchUpInside];
        push_disable.hidden = YES;

        [middle addSubview:push_disable];
        
        forgot = [[UIButton alloc] initWithFrame:CGRectMake(0, 41, 300, 39)];
        [forgot setBackgroundColor:[UIColor clearColor]];
        [forgot setBackgroundImage:[UIImage imageNamed:@"dw_sourceb.png"] forState:UIControlStateNormal];
        [forgot setTitleColor:[UIColor DwollaDarkGray] forState:UIControlStateNormal];
        forgot.titleLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:14];
        [forgot setTitle:@"Forgot Your PIN?" forState:UIControlStateNormal];
        [forgot addTarget:self action:@selector(forgotPin) forControlEvents:UIControlEventTouchUpInside];
        [middle addSubview:forgot];
    
        about = [[UIButton alloc] initWithFrame:CGRectMake(0, 81, 300, 39)];
        [about setBackgroundColor:[UIColor clearColor]];
        [about setBackgroundImage:[UIImage imageNamed:@"dw_sourceb.png"] forState:UIControlStateNormal];
        [about setTitleColor:[UIColor DwollaDarkGray] forState:UIControlStateNormal];
        about.titleLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:14];
        [about setTitle:@"About This App" forState:UIControlStateNormal];
        [about addTarget:self action:@selector(about) forControlEvents:UIControlEventTouchUpInside];
        [middle addSubview:about];
        
        logout = [[UIButton alloc] initWithFrame:CGRectMake(0, 125, 300, 40)];
        [logout setBackgroundImage:[UIImage imageNamed:@"dw_source.png"] forState:UIControlStateNormal];
        logout.layer.cornerRadius = 1.0;
        logout.layer.masksToBounds = YES;
        logout.clipsToBounds = YES;
        [logout setBackgroundColor:[UIColor clearColor]];
        [logout setTitleColor:[UIColor DwollaDarkGray] forState:UIControlStateNormal];
        logout.titleLabel.font = [UIFont fontWithName:@"GillSans-Bold" size:14];
        [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        [logout setTitle:@"Logout" forState:UIControlStateNormal];
        [middle addSubview:logout];
        
        
        transactions_view = [[ScrollableView alloc] init];
        [transactions_view setDelegate:self];
        transactions = 0;
        isSet = NO;
        
        nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [nav titleTextAttributes]];
        [titleBarAttributes setValue:[UIFont fontWithName:@"GillSans-Bold" size:16] forKey:UITextAttributeFont];
        [nav setTitleTextAttributes:titleBarAttributes];
        
        UIImage *originalImage = [UIImage imageNamed:@"dw_header.png"];
        // scaling set to 2.0 makes the image 1/2 the size.
        UIImage *scaledImage =
        [UIImage imageWithCGImage:[originalImage CGImage]
                            scale:(originalImage.scale * 2.0)
                      orientation:(originalImage.imageOrientation)];
        [nav setBackgroundImage:scaledImage forBarMetrics:UIBarMetricsDefault];
        
        UINavigationItem* detail_header = [[UINavigationItem alloc] initWithTitle:@"SETTINGS"];
        UIButton *backb = [UIButton buttonWithType:UIButtonTypeCustom];
        [backb addTarget:self action:@selector(slideOut) forControlEvents:UIControlEventTouchUpInside];
        backb.bounds = CGRectMake( 0, 0, 50, 30 );
        [backb setBackgroundImage:[UIImage imageNamed:@"dw_sdone.png"] forState:UIControlStateNormal];
        
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backb];
        [detail_header setRightBarButtonItem:back];
        [nav pushNavigationItem:detail_header animated:NO];
        nav.hidden = NO;
        [self.view addSubview:nav];
        
        loading = [[UIView alloc] initWithFrame:CGRectMake(20, 130, 280, 50)];
        [self.view addSubview:loading];
        loading.hidden = YES;
        
        
        NSLog(@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"push_enabled"]);
        
        if([[NSUserDefaults standardUserDefaults] boolForKey:@"push_enabled"] == YES){
            
            push_enable.hidden = YES;

            push_disable.hidden = NO;

        } else{
            
            push_disable.hidden = YES;
            
            push_enable.hidden = NO;
        }
        
    }
    return self;
}

-(void)addCommandCenter:(CommandCenter*)_command
{
    command = _command;
    [transactions_view addCommandCenter:_command];
}

-(void)setUserInfo:(NSMutableArray*)info
{
    name.text = [info objectAtIndex:1];
    _id.text = [info objectAtIndex:0];
    profile.image = [info objectAtIndex:2];
    profile.layer.cornerRadius = 3.0;
    profile.layer.masksToBounds = YES;
    profile.clipsToBounds = YES;
    isSet = YES;
}

- (BOOL)userInfoSet
{
    return isSet;
}

-(void)showTransactions
{
/// loading.hidden = NO;
    //[self loadingTransactions];
    [self addTransactions:transArray];
    [self.view addSubview:transactions_view];
    [transactions_view slideIn];
}

- (void)loadingTransactions
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(loadingTransactions2)];
    loading.backgroundColor = [UIColor DwollaGray];
    [UIView commitAnimations];
}

- (void)loadingTransactions2
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(loadingTransactions)];
    loading.backgroundColor = [UIColor DwollaOrange];
    [UIView commitAnimations];
}

-(void)hideTransactions
{
    [nav popNavigationItemAnimated:NO];
    [receipt_view slideOut];
    [transactions_view slideOut];
}

- (void)enablePush
{
    [[NSUserDefaults standardUserDefaults] setBool: YES forKey: @"push_enabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert |
                                                                           UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    NSLog(@"Setting the push channel to the userid" );
    
    NSString* uid = [NSString stringWithFormat:@"%@%@", @"user_", [command userId]];


    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    currentInstallation[@"enabled"] = @"1";
    currentInstallation[@"dwolla_accesstoken"] = [SSKeychain passwordForService:@"token" account:@"dwolla2"];
    currentInstallation[@"dwolla_uid"] = [command userId];
  //  currentInstallation[@"geo_device_id"] = [[AGSGTGeotriggerManager sharedManager] deviceId];
    [currentInstallation addUniqueObject:uid forKey:@"channels"];
    [currentInstallation saveInBackground];
    
    push_enable.hidden = YES;
    push_disable.hidden = NO;

    
    
}

- (void)disablePush

{
    [[NSUserDefaults standardUserDefaults] setBool: NO forKey: @"push_enabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    currentInstallation[@"enabled"] = @"0";
    [currentInstallation saveInBackground];
    
    push_enable.hidden = NO;
    push_disable.hidden =YES;

    
    
}

- (void)forgotPin
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.dwolla.com/forgot/pin"]];
}

- (void)about
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://github.com/brettneese/dwolla-here-iphone"]];
}

- (void)logout
{
    [[self delegate] logout];
}

- (void)backgroundTransactions:(NSMutableArray*)trans
{
    transArray = trans;
}

- (void)addTransactions:(NSMutableArray*)_transactions
{
    if (![previousTransaction isEqualTo:[_transactions objectAtIndex:0]])
    {
        transactions = [_transactions count];
        [transactions_view addTransactions:_transactions withDelegate:self];
        previousTransaction = [_transactions objectAtIndex:0];
    }
}

//- (void)slideIn
//{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:.4];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDelegate:self];
//    self.view.center = CGPointMake(160, screenBounds.size.height/2+30);
//    [UIView commitAnimations];
//}
//
//- (void)slideOut
//{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:.4];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(close)];
//    self.view.center = CGPointMake(-480, screenBounds.size.height/2+30);
//    [UIView commitAnimations];
//}

- (void)slideIn
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.view.center = CGPointMake(160, 20+(screenBounds.size.height - 100)/2);
    [UIView commitAnimations];
}
- (void)slideOut
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.view.center = CGPointMake(160, screenBounds.size.height + (screenBounds.size.height-80)/2);
    [UIView commitAnimations];
}
- (void)payReceipt
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:1.0];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationDidStopSelector:@selector(hideTransactions)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.view.center = CGPointMake(-480, 225);
    [UIView commitAnimations];
}

-(void)displayTransaction:(TransactionView*)transaction
{
    receipt_view = [[TransactionReceiptView alloc] init];
    [receipt_view setEverything:[transaction profile] name:[transaction name] amount:[transaction total] time:[transaction time] dwolla_id:[transaction dwolla_id] isSend:[transaction isSend] note:[transaction note]];
    receipt_view.delegate = (id<TransactionReceiptViewDelegate>)delegate;
    [self.view addSubview:receipt_view];
    [receipt_view slideIn];
}

- (void)loadTransactions
{
    NSMutableArray* toAdd = [command getTransactionsWithOffset:transactions];
    [transactions_view insertTransactions:toAdd withDelegate:self offset:transactions];
    transactions = [toAdd count];
}

- (void)close
{
    [[self delegate] closeSettings];
}

- (void)destory
{
    [top removeFromSuperview];
    top = nil;
    [middle removeFromSuperview];
    middle = nil;
    [bottom removeFromSuperview];
    bottom = nil;
    [profile removeFromSuperview];
    profile = nil;
    [name removeFromSuperview];
    name = nil;
    [_id removeFromSuperview];
    _id = nil;
    [transactionsb removeFromSuperview];
    transactionsb = nil;
    [push_disable removeFromSuperview];
    push_disable = nil;
    [forgot removeFromSuperview];
    forgot = nil;
    [about removeFromSuperview];
    about = nil;
    [logout removeFromSuperview];
    logout = nil;
    [nav removeFromSuperview];
    nav = nil;
    command = nil;
    [transactions_view destroyTransactions];
    [transactions_view removeFromSuperview];
    transactions_view = nil;
    [receipt_view removeFromSuperview];
    receipt_view = nil;
    delegate = nil;
    isSet = nil;
    transactions = nil;
    previousTransaction = nil;
}

- (void)dropRequests
{
    NSMutableArray* requests = [command userRequests];
    if ([requests count] > 0)
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelay:3.0];
        [UIView setAnimationDuration:.4];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        content.frame = CGRectMake(0, 82, 320, screenBounds.size.height - 140);
        [UIView commitAnimations];
        NSString* count = [NSString stringWithFormat:@"%d", [requests count]];
        if ([requests count] > 20)
        {
            count = @"20+";
        }
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelay:3.0];
        [UIView setAnimationDuration:.4];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
       // requests_header.center = CGPointMake(160, 20);
        content.frame = CGRectMake(0, 40, 320, screenBounds.size.height - 100);
        [UIView commitAnimations];
        //num_requests.text = [NSString stringWithFormat:@"%d", [requests count]];
    }
}


- (void)loadRequests
{
    [ProgressHUD show:@"Please wait..."];
    [self performSelector:@selector(showRequests)];
    

}


- (void)showRequests
{

    requests_scroll = [[ScrollableView alloc] init];
    [requests_scroll addCommandCenter:command];
    [requests_scroll addRequests:[command userRequests] withDelegate:self ];
    [self.view addSubview:requests_scroll];
    
    nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    NSMutableDictionary *titleBarAttributes = [NSMutableDictionary dictionaryWithDictionary: [nav titleTextAttributes]];
    [titleBarAttributes setValue:[UIFont fontWithName:@"GillSans-Bold" size:16] forKey:UITextAttributeFont];
    [nav setTitleTextAttributes:titleBarAttributes];
    
    UIImage *originalImage = [UIImage imageNamed:@"dw_header.png"];
    // scaling set to 2.0 makes the image 1/2 the size.
    UIImage *scaledImage =
    [UIImage imageWithCGImage:[originalImage CGImage]
                        scale:(originalImage.scale * 2.0)
                  orientation:(originalImage.imageOrientation)];
    [nav setBackgroundImage:scaledImage forBarMetrics:UIBarMetricsDefault];
    
    [requests_scroll addSubview:nav];
    
    UINavigationItem* detail_header = [[UINavigationItem alloc] initWithTitle:@"REQUESTS"];
    UIButton *backb = [UIButton buttonWithType:UIButtonTypeCustom];
    [backb addTarget:self action:@selector(popToMain) forControlEvents:UIControlEventTouchUpInside];
    backb.bounds = CGRectMake( 0, 0, 50, 30 );
    [backb setBackgroundImage:[UIImage imageNamed:@"dw_sdone.png"] forState:UIControlStateNormal];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backb];
    [detail_header setRightBarButtonItem:back];
    [nav pushNavigationItem:detail_header animated:NO];
    [requests_scroll bringSubviewToFront:nav];
    nav.hidden = NO;

    [requests_scroll slideIn];
    [ProgressHUD dismiss];

}

-(void)displayRequest:(RequestView*)request
{
    request_controller = [[RequestViewController alloc] init];
    [request_controller addRequest:request];
    [request_controller addCommandCenter:command];
    [self.view addSubview:request_controller.view];
    [request_controller slideIn];
    [request_controller.view bringSubviewToFront:nav];

}

- (void)popToRequests
{
    [request_controller slideOut];
}

- (void)popToMain
{
    [nav popNavigationItemAnimated:NO];
    [requests_scroll slideOut];
    [request_controller slideOut];
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

@end