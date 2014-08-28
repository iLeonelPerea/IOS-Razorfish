//
//  MainViewController.m
//  testTableView
//
//  Created by Leonel Roberto Perea Trejo on 8/27/14.
//  Copyright (c) 2014 Leonel Roberto Perea Trejo. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize tblView, arrData, HUDJMProgress;

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
    self.navigationItem.title = @"Product List";
    arrData = [NSMutableArray new];
    [tblView setDelegate:self];
    [tblView setDataSource:self];
    UINib *nib = [UINib nibWithNibName:@"ItemCell" bundle:nil];
    [[self tblView] registerNib:nib forCellReuseIdentifier:@"ItemCell"];
    HUDJMProgress = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleExtraLight];
    HUDJMProgress.textLabel.text = @"Loading";
    [self loadProductsData];
}

-(void)loadProductsData{
    [HUDJMProgress showInView:self.view];
    NSURL *url = [NSURL URLWithString:@"http://aroma-bakery-cafe.herokuapp.com/admin/foods.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSLog(@"Cargando Datos...");
        if(!error)
        {
            NSDictionary * dictFoodsGeneral = [NSJSONSerialization JSONObjectWithData: data options:kNilOptions error:nil];
            NSArray * arrFoods = [dictFoodsGeneral objectForKey:@"foods"];
            for (NSDictionary * dictFood in arrFoods)
            {
                for(NSDictionary * dictFoodFinal in [dictFood objectForKey:@"foods"])
                {
                    [arrData addObject:dictFoodFinal];
                }
            }
            NSLog(@"tu array de datos final tiene: %d registros", [arrData count]);
            [HUDJMProgress dismissAfterDelay:0.1];
            [tblView reloadData];
        }
    }];
}

#pragma mark - Table view data delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CellProduct";
    ProductCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ProductCellTableViewCell" owner:self options:nil][0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary *dictFinalProduct = [arrData objectAtIndex:indexPath.row];
    cell.lblProductName.text = ([dictFinalProduct objectForKey:@"name"]) != [NSNull null] ?[NSString stringWithFormat:@"%@", [dictFinalProduct objectForKey:@"name"]]:@"No Name";
    NSString *url = ([dictFinalProduct objectForKey:@"picture_thumb"] != [NSNull null])? [NSString stringWithFormat:@"%@",[dictFinalProduct objectForKey:@"picture_thumb"]]:@"";
    
    cell.lblProductName.text = ([dictFinalProduct objectForKey:@"description"]) != [NSNull null] ?[NSString stringWithFormat:@"%@", [dictFinalProduct objectForKey:@"description"]]:@"No Description";
    
    if(![url isEqual:@""]){
        [[[AsyncImageDownloader alloc] initWithFileURL:url successBlock:^(NSData *data) {
            [cell.imgProduct setImage:[UIImage imageWithData:data]];
        } failBlock:^(NSError *error) {
            NSLog(@"Failed to download image due to %@!", error);
        }] startDownload];
    }
    else{
        [cell.imgProduct setImage:[UIImage imageNamed:@"noAvail.png"]];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductInfoViewController *producInfoViewController = [[ProductInfoViewController alloc] init];
    producInfoViewController.dictFinalProduct = [arrData objectAtIndex:indexPath.row];    
    [self.navigationController pushViewController:producInfoViewController animated:YES];
    
    //Here
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
