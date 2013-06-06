//
//  DetailViewController.m
//  MyMusic
//
//  Created by Florian Heller on 3/18/13.
//  Copyright (c) 2013 Florian Heller - RWTH Aachen University. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)configureView
{
    // Update the user interface for the detail item.

	self.imgView.image = self.itemimage;
	self.itemLabel.text = self.itemName;
	self.sharedLabel.text = self.sharedBy;
	self.fromLabel.text = self.from;
	self.toLabel.text = self.to;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
