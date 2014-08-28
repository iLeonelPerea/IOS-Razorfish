//
//  ProductInfoViewController.h
//  testTableView
//
//  Created by Leonel Roberto Perea Trejo on 8/28/14.
//  Copyright (c) 2014 Leonel Roberto Perea Trejo. All rights reserved.
//

#import "ViewController.h"

@interface ProductInfoViewController : ViewController

@property (nonatomic, strong) NSMutableArray *arrData;
@property(nonatomic, strong) IBOutlet UILabel *lblProductInfoId;
@property(nonatomic, strong) IBOutlet UILabel *lblProductInfoDescription;
@property(nonatomic, strong) IBOutlet UILabel *lblProductDescriptionCategory;

@end
