//
//  ViewController.h
//  TipCalculator
//
//  Created by Viviane Chan on 2016-07-08.
//  Copyright © 2016 LightHouse Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic)IBOutlet UITextField *billAmountTextField;

@property (weak, nonatomic)IBOutlet UISlider* slider;

@property (weak, nonatomic)IBOutlet UILabel *tipPercentageLabel;


@property (weak, nonatomic)IBOutlet UILabel *finalTipLabel;

@end

