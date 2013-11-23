//
//  RequestSlipView.m
//  DwollaV2
//
//  Created by Nick Schulze on 6/4/13.
//  Copyright (c) 2013 Nick Schulze. All rights reserved.
//

#import "RequestSlipView.h"

@implementation RequestSlipView

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        screenBounds = [[UIScreen mainScreen] bounds];
        self.frame = CGRectMake(0, 0, 320, screenBounds.size.height+60);
        self.backgroundColor = [UIColor DwollaGray];
        
        top = [[RoundedView alloc] initWithFrame:CGRectMake(10, 10, 300, 340)];
        top.backgroundColor = [UIColor whiteColor];
        [self addSubview:top];
        
        profile = [[UIImageView alloc] initWithFrame:CGRectMake(125, 10, 50, 50)];
        [top addSubview:profile];
        
        name = [[BoldTextView alloc] initWithFrame:CGRectMake(70, 65, 160, 25)];
        name.textAlignment = NSTextAlignmentCenter;
        [top addSubview:name];
        
        timebg = [[UIImageView alloc] initWithFrame:CGRectMake(55, 90, 190, 25)];
        timebg.image = [UIImage imageNamed:@"dw_timebanner.png"];
        [timebg setBackgroundColor:[UIColor clearColor]];
        [top addSubview:timebg];
        
        time = [[BoldTextView alloc] initWithFrame:CGRectMake(70, 86, 180, 25)];
        [time setTextColor:[UIColor whiteColor]];
        [top addSubview:time];
        
        UIImageView* dash = [[UIImageView alloc] initWithFrame:CGRectMake(0, 130, 300, 2)];
        dash.image = [UIImage imageNamed:@"dw_dash.png"];
        [top addSubview:dash];
        
        total = [[BoldTextView alloc] initWithFrame:CGRectMake(10, 140, 100, 25)];
        [total setText:@"TOTAL"];
        [top addSubview:total];
        
        amount = [[LightTextView alloc] initWithFrame:CGRectMake(200, 134, 100, 40)];
        amount.textAlignment = NSTextAlignmentRight;
        [amount setFont:[UIFont fontWithName:@"GillSans-Light" size:24]];
        [top addSubview:amount];
        
        UIImageView* dash2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 180, 300, 2)];
        dash2.image = [UIImage imageNamed:@"dw_dash.png"];
        [top addSubview:dash2];
        
        note_button = [[UIButton alloc] initWithFrame:CGRectMake(10, 195, 20, 20)];
        [note_button setImage:[UIImage imageNamed:@"dw_note.png"] forState:UIControlStateNormal];
        [top addSubview:note_button];
        
        note = [[UITextView alloc] initWithFrame:CGRectMake(30, 195, 235, 60)];
        [note setBackgroundColor:[UIColor clearColor]];
        [note setUserInteractionEnabled:NO];
        [note setTextColor:[UIColor DwollaDarkGray]];
        [top addSubview:note];
        
        request = [[UIButton alloc] initWithFrame:CGRectMake(10, 270, 280, 50)];
        [request setImage:[UIImage imageNamed:@"dw_compay.png"] forState:UIControlStateNormal];
        [request addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
        [top addSubview:request];
        
        cancel = [[UIButton alloc] initWithFrame:CGRectMake(10, 270, 280, 50)];
        [cancel setImage:[UIImage imageNamed:@"dw_confirm.png"] forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [top addSubview:cancel];
    }
    return self;
}

-(void)setEverything:(UIImage*)_profile name:(NSString*)_name amount:(NSString*)_amount time:(NSString*)_time dwolla_id:(NSString*)_dwolla youRequested:(BOOL) youRequested
{
    profile.image = _profile;
    profile.layer.cornerRadius = 3.0;
    profile.layer.masksToBounds = YES;
    profile.clipsToBounds = YES;
    name.text = _name;
    amount.text = _amount;
    time.text = _time;
    dwolla_id = _dwolla;
    if (youRequested)
    {
        request.hidden = YES;
        cancel.hidden = NO;
    }
}

- (void)complete
{
    [[self delegate] payRequest:self];
}

- (void)cancel
{
    [[self delegate] cancelRequest:self];
}

-(NSString*)amount
{
    return amount.text;
}

-(NSString*)name
{
    return name.text;
}

-(UIImage*)profile
{
    return profile.image;
}

-(NSString*)dwolla_id
{
    return dwolla_id;
}

-(NSString*)time
{
    return time.text;
}

- (void)slideIn
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.center = CGPointMake(160, (screenBounds.size.height/2));
    [UIView commitAnimations];
}

- (void)slideOut
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    self.center = CGPointMake(480, screenBounds.size.height/2);
    [UIView commitAnimations];
}
@end

