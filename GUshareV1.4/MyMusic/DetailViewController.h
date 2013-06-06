//
//  DetailViewController.h
//  MyMusic
//
//  Created by Florian Heller on 3/18/13.
//  Copyright (c) 2013 Florian Heller - RWTH Aachen University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSString *itemName;
@property (strong, nonatomic) NSString *sharedBy;
@property (strong, nonatomic) NSString *from;
@property (strong, nonatomic) NSString *to;
@property (strong, nonatomic) UIImage *itemimage;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UILabel *sharedLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;



@end
