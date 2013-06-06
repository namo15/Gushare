//
//  shareItem.m
//  MyMusic
//
//  Created by Maclab on 6/5/13.
//  Copyright (c) 2013 Florian Heller - RWTH Aachen University. All rights reserved.
//

#import "shareItem.h"
#define kPickerAnimationDuration 0.40


@interface shareItem ()


@property (nonatomic, strong) IBOutlet UIDatePicker *pickerView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneButton;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;


@end



@implementation shareItem // why it this warnning?

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


// When the setDate button is clicked, call:



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.


    
    self.dataArray = [NSArray arrayWithObjects:@"Start Date", @"End Date", nil];
  
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [self.dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	
	self.fromTextField.text = [self.dateFormatter stringFromDate:[NSDate date]];
    self.toTextField.text = [self.dateFormatter stringFromDate:[NSDate date]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions


- (void)slideDownDidStop
{
	// the date picker has finished sliding downwards, so remove it from the view hierarchy
	[self.pickerView removeFromSuperview];
}

//FH: changed to shouldBeginEditing
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	// If this is a textfield that should show the datepicker (in this case the self.from textfield)
	// we return no to prevent the keyboard to appear. Instead we show the datepicker.
    
	if (textField==self.fromTextField) {
		// Be sure to use the text of the textfield and not the reference to the textfield itself (which leads to a crash).
		NSDate *dateToPick = [self.dateFormatter dateFromString:self.fromTextField.text];
		//self.pickerView.date = [self.dateFormatter dateFromString:self.from.text]; //problem??
		self.pickerView.date = dateToPick;
        
		// the date picker might already be showing, so don't add it to our view
		if (self.pickerView.superview == nil)
		{
			CGRect startFrame = self.pickerView.frame;
			CGRect endFrame = self.pickerView.frame;
			
			// the start position is below the bottom of the visible frame
			startFrame.origin.y = self.view.frame.size.height;
			
			// the end position is slid up by the height of the view
			endFrame.origin.y = startFrame.origin.y - endFrame.size.height;
			
			self.pickerView.frame = startFrame;
			
			[self.view addSubview:self.pickerView];
			
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:kPickerAnimationDuration];
			self.pickerView.frame = endFrame;
			[UIView commitAnimations];
			
			// add the "Done" button to the nav bar
			// FH: changed this to show a Done button, it showed an "item" button only when I tried.
			// self.navigationItem.rightBarButtonItem = self.doneButton;
			self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(doneAction:)];
		}
		return NO;
	}
    if (textField==self.toTextField) {
		// Be sure to use the text of the textfield and not the reference to the textfield itself (which leads to a crash).
		NSDate *dateToPick = [self.dateFormatter dateFromString:self.toTextField.text];
		//self.pickerView.date = [self.dateFormatter dateFromString:self.from.text]; //problem??
		self.pickerView.date = dateToPick;
        
		// the date picker might already be showing, so don't add it to our view
		if (self.pickerView.superview == nil)
		{
			CGRect startFrame = self.pickerView.frame;
			CGRect endFrame = self.pickerView.frame;
			
			// the start position is below the bottom of the visible frame
			startFrame.origin.y = self.view.frame.size.height;
			
			// the end position is slid up by the height of the view
			endFrame.origin.y = startFrame.origin.y - endFrame.size.height;
			
			self.pickerView.frame = startFrame;
			
			[self.view addSubview:self.pickerView];
			
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:kPickerAnimationDuration];
			self.pickerView.frame = endFrame;
			[UIView commitAnimations];
			
			// add the "Done" button to the nav bar
			// FH: changed this to show a Done button, it showed an "item" button only when I tried.
			// self.navigationItem.rightBarButtonItem = self.doneButton;
			self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(doneAction:)];
		}
		return NO;
	
    }
	//Else: 
	return YES;
           
    
}



//FH: this makes the return button work on the keyboard.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (IBAction)doneAction:(id)sender
{
    CGRect pickerFrame = self.pickerView.frame;
    pickerFrame.origin.y = self.view.frame.size.height;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:kPickerAnimationDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(slideDownDidStop)];
    self.pickerView.frame = pickerFrame;
    [UIView commitAnimations];
    
	// remove the "Done" button in the nav bar
	self.navigationItem.rightBarButtonItem = nil;
	

}


- (IBAction)uploadPhoto:(id)sender {
    UIImagePickerController *picker ;
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (IBAction)uploadCam:(id)sender {
    
    UIImagePickerController *picker ;
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];

}

- (IBAction)save:(id)sender {
    
    // get paths from root direcory
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"music.plist"];
    
    //Load the original file
    NSMutableArray *arr;
    if([[NSFileManager defaultManager] fileExistsAtPath:plistPath])
        //File exist load
        arr = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    else
        //File does not exist create
        arr = [[NSMutableArray alloc] init];
    
    // set the variables to the values in the text fields
    self.itemName = itemNameEntered.text;
    self.sharedBy = sharedByEntered.text;
    
    self.from = fromEntered.text; // need to convert to NSDate
 //  self.to = [NSDate toEntered.text]; // need to convert to NSDate
    
    
    //Create dictionary how to go to a subdirectory in plist?
    NSDictionary *plistDict = [NSDictionary dictionaryWithObjects: [NSArray arrayWithObjects: itemName,sharedBy,from, to, nil] forKeys:[NSArray arrayWithObjects: @"itemname",@"sharedby", @"from",@"to",nil]]; 
    
    //Append to arr
    [arr addObject:plistDict];
    
    //Save to file
    [arr writeToFile:plistPath atomically:YES];
}
@end
