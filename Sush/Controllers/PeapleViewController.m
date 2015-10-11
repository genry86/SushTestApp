//
//  PeapleViewController.m
//  Sush
//
//  Created by Genry on 11/16/14.
//  Copyright (c) 2014 Genry. All rights reserved.
//

//
//  PeapleViewController.m
//  Sush
//
//  Created by Genry on 11/16/14.
//  Copyright (c) 2014 Genry. All rights reserved.
//

#import "PeapleViewController.h"
#import "HumanItem.h"
#import "DownloadDataHelper.h"


@interface PeapleViewController ()
@property (nonatomic, strong) NSMutableArray *peapleItems;
@end

@implementation PeapleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _peapleItems = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self downloadData];
}


- (void)downloadData
{
    __weak PeapleViewController *weakSelf = self;
    
    [ProgressHUD show:@"Please wait..."];
    
    DownloadDataHelper *downloadDataHelper = [DownloadDataHelper sharedInstance];
    [downloadDataHelper downloadJSON:kJSONDataULRAddress
                     completionBlock:^(NSArray *peapleItems)
     {
         [peapleItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
          {
              NSString *name         =  [obj valueForKey:kJSONDataItemNameField];
              NSString *title        =  [obj valueForKey:kJSONDataItemTitleField];
              NSString *imageUrl     =  [obj valueForKey:kJSONDataItemImageField];
              NSString *birthdayStr  =  [obj valueForKey:kJSONDataItemBirthdayField];
              
              NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
              [dateFormat setDateFormat:@"MMM dd, yyyy"];  //"February 24, 1955"
              NSDate *birthday = [dateFormat dateFromString:birthdayStr];

              HumanItem *humanItem = [HumanItem new];
              
              if (title && [title length] > 0) humanItem.title = title;
              if (name && [name length] > 0)  humanItem.name = name;
              if (birthday)  humanItem.birthday = birthday;
              
              if (imageUrl)
              {
                  NSString *key = [imageUrl MD5String];
                  NSData *data  = [FTWCache objectForKey:key];
                  
                  if (data)
                  {
                      humanItem.image = [UIImage imageWithData:data];
                  }
                  else
                  {
                      NSURL *url     = [[NSURL alloc] initWithString:imageUrl];
                      NSData *data   = [NSData dataWithContentsOfURL:url];
                      UIImage *image = [UIImage imageWithData:data];
                      image          = [image imageByScalingAndCroppingForSize:CGSizeMake(kTableViewCellHeight, kTableViewCellHeight)];
                      
                      NSData *imageData;
                      if ([data contentTypeForImageData] == ImageTypePNG)
                      {
                          imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
                      }
                      else if([data contentTypeForImageData] == ImageTypeJPEG)
                      {
                          imageData = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0)];
                      }
                      
                      if (imageData)
                      {
                          [FTWCache setObject:imageData forKey:key];
                          humanItem.image = image;
                      }
                      else
                      {
                          NSLog(@"Bad image data");
                      }
                  }
              }
              [_peapleItems addObject:humanItem];
          }];
         
         [weakSelf.peapleTableView reloadData];
                  [ProgressHUD dismiss];
     }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _peapleItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text  = nil;
    cell.imageView.image = nil;
    
    NSUInteger      row         = [indexPath row];
    HumanItem *humanItem = _peapleItems[row];
    
    if (humanItem.name)
    {
        cell.textLabel.text = humanItem.name;
    }
    else
    {
        cell.textLabel.text = @"No Name";
    }
    if (humanItem.title)
    {
        cell.detailTextLabel.text = humanItem.title;
    }
    else
    {
        cell.detailTextLabel.text = @"No Title";
    }
    
    if (humanItem.image) cell.imageView.image = humanItem.image;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitYear | NSCalendarUnitDay
                                               fromDate:humanItem.birthday
                                                 toDate:[NSDate date]
                                                options:0];
    
    CGRect Label1Frame = CGRectMake(CGRectGetWidth(cell.frame) + 30, 5,18,18);  // not good solution but don't have much time :)
    UILabel *lblTemp = [[UILabel alloc] initWithFrame:Label1Frame];
    [lblTemp setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15]];
    lblTemp.backgroundColor=[UIColor clearColor];
    lblTemp.numberOfLines=0;
    lblTemp.text = [NSString stringWithFormat:@"%li",  (long)components.year];
    [cell.contentView addSubview:lblTemp];

    return cell;
}


@end
