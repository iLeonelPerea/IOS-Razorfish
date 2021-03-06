//
//  MainScreenViewController.m
//  IOSLinkedInAPI-Podexample
//
//  Created by Omar Guzmán on 10/8/14.
//  Copyright (c) 2014 Eyben Consult ApS. All rights reserved.
//

#import "MainScreenViewController.h"
#import "LinkedInProfileViewController.h"
#import "DBManager.h"

@interface MainScreenViewController ()

@end

@implementation MainScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doOpenFeedbackView) name:@"feedbackNotification" object:nil];
    [DBManager checkOrCreateDataBase];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Methods

-(void)didTapConnectWithLinkedIn:(id)sender
{
    LinkedInProfileViewController * lipVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LinkedInProfile"];
    [self.navigationController pushViewController:lipVC animated:YES];
}

-(void)doOpenFeedbackView
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"feedbackNotification" object:nil];
    FeedbackViewController * feedbackViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedbackViewController"];
    [self.navigationController pushViewController:feedbackViewController animated:YES];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
