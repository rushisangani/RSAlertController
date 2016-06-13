# RSAlertController

A beautiful customizable **AlertViewController** with dyanmic buttons. 
RSAlertController can be used to show Alert with one, two, three buttons from any ViewController.


![Alt text](/Images/alert1.png?raw=true "Alert 1")       ![Alt text](/Images/alert2.png?raw=true "Alert 2")


## Features

- Show AlertView as a ViewController.
- Customizable Title, message and buttons color.
- Automatic buttons layout for more than two buttons.
- Automatic dimiss on Tap outside.
- Get button's click event inside block.

## How To Use

### Show Simple Alert

```objective-c
[[RSAlertViewController sharedInstance] showAlertWithTitle:@"Alert" message:@"Do you want to confirm?" buttons:@[@"Cancel", @"OK"] fromViewController:self withActionHandler:^(NSUInteger buttonIndex) {

    NSLog(@"button clicked at Index %lu", buttonIndex);
}];
```

### Show Custom Alert

```objective-c
RSAlertViewController *alertView = [[RSAlertViewController sharedInstance] showAlertWithTitle:@"Success" message:@"Do you want to proceed?\n\nAnswer by selecting one of the three option." buttons:@[@"No", @"Yes", @"Never"] fromViewController:self withActionHandler:^(NSUInteger buttonIndex) {

    NSLog(@"button clicked at Index %lu", buttonIndex);

}];

alertView.dismissOnTapOutside = YES;
alertView.textAlignment = NSTextAlignmentLeft;
```

## License

RSAlertViewController is released under the MIT license. See LICENSE for details.
