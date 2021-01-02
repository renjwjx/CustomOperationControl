//
//  ViewController.m
//  CustomOperationControl
//
//  Created by renjinwei on 2021/1/1.
//  Copyright © 2021 renjinwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSOperationQueue* queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    self.queue = queue;
    queue.maxConcurrentOperationCount = 2;
}

- (IBAction)startBtn:(id)sender {
    [self operationBlock];
}

- (IBAction)suspendBtn:(id)sender {
    //只能suspend还没有开始的operation
    [self.queue setSuspended:YES];
}

- (IBAction)continueBtn:(id)sender {
    [self.queue setSuspended:NO];
}

- (IBAction)cancelBtn:(id)sender {
    [self.queue cancelAllOperations];
}

- (void)operationBlock
{
    NSBlockOperation* block1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 1000; i++) {
            NSLog(@"block1 -%d-- %@", i, [NSThread currentThread]);
        }
    }];
    NSBlockOperation* block2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 1000; i++) {
            NSLog(@"block2 -%d- %@", i, [NSThread currentThread]);
        }
    }];
    NSBlockOperation* block3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 1000; i++) {
            NSLog(@"block3 -%d- %@", i, [NSThread currentThread]);
        }
    }];

    [_queue addOperation:block1];
    [_queue addOperation:block2];
    [_queue addOperation:block3];
    
    [_queue addOperationWithBlock:^{
                NSLog(@"add operation block-- %@", [NSThread currentThread]);
    }];
}

@end
