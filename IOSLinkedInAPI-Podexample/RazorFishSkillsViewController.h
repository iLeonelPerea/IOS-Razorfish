//
//  RazorFishSkillsViewController.h
//  IOSLinkedInAPI-Podexample
//
//  Created by Omar Guzmán on 10/8/14.
//  Copyright (c) 2014 Eyben Consult ApS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RazorFishSkillsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
// properties
@property (nonatomic, strong) NSMutableArray * arrSkills;
@property (nonatomic, strong) IBOutlet UITableView * tblSkills;
@end
