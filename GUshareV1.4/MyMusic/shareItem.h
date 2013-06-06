

#import <UIKit/UIKit.h>

@interface shareItem : UIViewController<UIActionSheetDelegate, UISplitViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

{
    IBOutlet UITextField *itemNameEntered;
    IBOutlet UITextField *sharedByEntered;
    IBOutlet UITextField *fromEntered;
    IBOutlet UITextField *toEntered;


    
    NSString *itemName;
    NSString *sharedBy;
    NSDate *from;
    NSDate *to;
}

//@property (nonatomic, retain)	UITextField		*itemNameText;
//@property (nonatomic, retain)	UITextField		*sharedBytext;
@property (weak, nonatomic) IBOutlet UITextField *fromTextField;
@property (weak, nonatomic) IBOutlet UITextField *toTextField;

@property (nonatomic, retain)	NSString		*itemName;
@property (nonatomic, retain)	NSString		*sharedBy;
@property (nonatomic, retain)	NSDate		*from;
@property (nonatomic, retain)	NSDate		*to;

- (IBAction)uploadPhoto:(id)sender;
- (IBAction)uploadCam:(id)sender;
- (IBAction)save:(id)sender;

@end
