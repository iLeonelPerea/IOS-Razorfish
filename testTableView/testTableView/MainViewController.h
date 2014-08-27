//
//  MainViewController.h
//  testTableView
//
//  Created by Leonel Roberto Perea Trejo on 8/27/14.
//  Copyright (c) 2014 Leonel Roberto Perea Trejo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductCellTableViewCell.h"

@interface MainViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)IBOutlet UITableView *tblView;
@property (nonatomic, strong) NSMutableArray *arrData;

@end
