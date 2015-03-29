//
//  GBIAPAnalyticsModule.m
//  GBIAPExtras
//
//  Created by Luka Mirosevic on 21/05/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import "GBIAPAnalyticsModule.h"

#import <GBAnalytics/GBAnalytics.h>
#import <GBToolbox/GBToolbox.h>
#import <GBDeviceInfo/GBDeviceInfo.h>

@interface GBIAPAnalyticsModule ()

@property (assign, nonatomic) BOOL isJailbroken;

@end

@implementation GBIAPAnalyticsModule

#pragma mark - API

- (instancetype)init {
    if (self = [super init]) {
        self.isJailbroken = [GBDeviceInfo deviceInfo].isJailbroken;
    }
    
    return self;
}

#pragma mark - GBIAP2AnalyticsModule

- (void)iapManagerDidResumeTransactions {
    [GBAnalytics trackEvent:@"GBIAP2: Resumed transactions" withParameters:@{@"jailbroken": _b(self.isJailbroken)}];
}

- (void)iapManagerDidRegisterValidationServers:(NSArray *)servers {
    [GBAnalytics trackEvent:@"GBIAP2: Registered validation servers" withParameters:@{@"servers": servers.shortStringRepresentation, @"jailbroken": _b(self.isJailbroken)}];
}

- (void)iapManagerUserDidRequestMetadataForProducts:(NSArray *)productIdentifiers {
    [GBAnalytics trackEvent:@"GBIAP2: Requested metadata" withParameters:@{@"products": Stringify(productIdentifiers.shortStringRepresentation), @"jailbroken": _b(self.isJailbroken)}];
}

- (void)iapManagerUserDidRequestPurchaseForProduct:(NSString *)productIdentifier {
    [GBAnalytics trackEvent:@"GBIAP2: Requested purchase" withParameters:@{@"product": Stringify(productIdentifier), @"jailbroken": _b(self.isJailbroken)}];
}

- (void)iapManagerUserDidRequestRestore {
    [GBAnalytics trackEvent:@"GBIAP2: Requested restore" withParameters:@{@"jailbroken": _b(self.isJailbroken)}];
}

- (void)iapManagerDidBeginMetadataFetchForProducts:(NSArray *)productIdentifiers {
    [GBAnalytics trackEvent:@"GBIAP2: Began metadata fetch" withParameters:@{@"products": Stringify(productIdentifiers.shortStringRepresentation), @"jailbroken": _b(self.isJailbroken)}];
}

- (void)iapManagerDidEndMetadataFetchForProducts:(NSArray *)productIdentifiers state:(GBIAP2MetadataFetchState)state {
    NSString *stateString;
    switch (state) {
        case GBIAP2MetadataFetchStateUnknown: {
            stateString = @"Unknown";
        } break;

        case GBIAP2MetadataFetchStateSuccess: {
            stateString = @"Success";
        } break;

        case GBIAP2MetadataFetchStateFailed: {
            stateString = @"Failed";
        } break;
    }
    
    [GBAnalytics trackEvent:@"GBIAP2: Ended metadata fetch" withParameters:@{@"products": Stringify(productIdentifiers.shortStringRepresentation), @"state": stateString, @"jailbroken": _b(self.isJailbroken)}];
}

- (void)iapManagerDidBeginPurchaseForProduct:(NSString *)productIdentifier {
    [GBAnalytics trackEvent:@"GBIAP2: Began purchase phase" withParameters:@{@"product": Stringify(productIdentifier), @"jailbroken": _b(self.isJailbroken)}];
}

- (void)iapManagerDidEndPurchaseForProduct:(NSString *)productIdentifier state:(GBIAP2PurchaseState)state solicited:(BOOL)solicited {
    NSString *stateString;
    switch (state) {
        case GBIAP2PurchaseStateUnknown: {
            stateString = @"Unknown";
        } break;

        case GBIAP2PurchaseStateSuccess: {
            stateString = @"Success";
        } break;
            
        case GBIAP2PurchaseStateCancelled: {
            stateString = @"Cancelled";
        } break;
            
        case GBIAP2PurchaseStateFailed: {
            stateString = @"Failed";
        } break;
    }
    
    [GBAnalytics trackEvent:@"GBIAP2: Ended purchase phase" withParameters:@{@"product": Stringify(productIdentifier), @"state": stateString, @"solicited": _b(solicited), @"jailbroken": _b(self.isJailbroken)}];
}

- (void)iapManagerDidBeginRestore {
    [GBAnalytics trackEvent:@"GBIAP2: Began restore" withParameters:@{@"jailbroken": _b(self.isJailbroken)}];
}

- (void)iapManagerDidEndRestoreForProduct:(NSString *)productIdentifier state:(GBIAP2PurchaseState)state solicited:(BOOL)solicited {
    NSString *stateString;
    switch (state) {
        case GBIAP2PurchaseStateUnknown: {
            stateString = @"Unknown";
        } break;

        case GBIAP2PurchaseStateSuccess: {
            stateString = @"Success";
        } break;

        case GBIAP2PurchaseStateCancelled: {
            stateString = @"Cancelled";
        } break;

        case GBIAP2PurchaseStateFailed: {
            stateString = @"Failed";
        } break;
    }
    
    [GBAnalytics trackEvent:@"GBIAP2: Ended restore phase for product" withParameters:@{@"product": Stringify(productIdentifier), @"state": stateString, @"solicited": _b(solicited), @"jailbroken": _b(self.isJailbroken)}];
}

- (void)iapManagerDidBeginVerificationForProduct:(NSString *)productIdentifier onServer:(NSString *)server {
    [GBAnalytics trackEvent:@"GBIAP2: Began verification phase" withParameters:@{@"product": Stringify(productIdentifier), @"server": server, @"jailbroken": _b(self.isJailbroken)}];
}

- (void)iapManagerDidEndVerificationForProduct:(NSString *)productIdentifier onServer:(NSString *)server state:(GBIAP2VerificationState)state {
    NSString *stateString;
    switch (state) {
        case GBIAP2VerificationStateUnknown: {
            stateString = @"Unknown";
        } break;

        case GBIAP2VerificationStateSuccess: {
            stateString = @"Success";
        } break;

        case GBIAP2VerificationStateFailed: {
            stateString = @"Failed";
        } break;
    }
    
    [GBAnalytics trackEvent:@"GBIAP2: Ended verification phase" withParameters:@{@"product": Stringify(productIdentifier), @"server": server, @"state": stateString, @"jailbroken": _b(self.isJailbroken)}];
}

- (void)iapManagerDidSuccessfullyAcquireProduct:(NSString *)productIdentifier withTransactionType:(GBIAP2TransactionType)transactionType transactionState:(GBIAP2TransactionState)transactionState solicited:(BOOL)solicited {
    NSString *transactionTypeString;
    switch (transactionType) {
        case GBIAP2TransactionTypeUnknown: {
            transactionTypeString = @"Unknown";
        } break;
            
        case GBIAP2TransactionTypePurchase: {
            transactionTypeString = @"Purchase";
        } break;
            
        case GBIAP2TransactionTypeRePurchase: {
            transactionTypeString = @"RePurchase";
        } break;
            
        case GBIAP2TransactionTypeRestore: {
            transactionTypeString = @"Restore";
        } break;
    }

    NSString *transactionStateString;
    switch (transactionState) {
        case GBIAP2TransactionStateUnknown: {
            transactionStateString = @"Unknown";
        } break;

        case GBIAP2TransactionStateSuccess: {
            transactionStateString = @"Success";
        } break;

        case GBIAP2TransactionStateCancelled: {
            transactionStateString = @"Cancelled";
        } break;

        case GBIAP2TransactionStateFailed: {
            transactionStateString = @"Failed";
        } break;
    }
    
    [GBAnalytics trackEvent:@"GBIAP2: Successfully acquired product" withParameters:@{@"product": Stringify(productIdentifier), @"transactionType": transactionTypeString, @"transactionState": transactionStateString, @"solicited": _b(solicited), @"jailbroken": _b(self.isJailbroken)}];
    
    //Break them down again because Flurry and Google Analytics ain't that great
    if (transactionType == GBIAP2TransactionTypePurchase) {
        [GBAnalytics trackEvent:@"GBIAP2: Actually purchased" withParameters:@{@"product": Stringify(productIdentifier), @"solicited": _b(solicited), @"jailbroken": _b(self.isJailbroken)}];
    }
    else if (transactionType == GBIAP2TransactionTypeRePurchase) {
        [GBAnalytics trackEvent:@"GBIAP2: Actually repurchased" withParameters:@{@"product": Stringify(productIdentifier), @"solicited": _b(solicited), @"jailbroken": _b(self.isJailbroken)}];
    }
    else if (transactionType == GBIAP2TransactionTypeRestore) {
        [GBAnalytics trackEvent:@"GBIAP2: Actually restored" withParameters:@{@"product": Stringify(productIdentifier), @"solicited": _b(solicited), @"jailbroken": _b(self.isJailbroken)}];
    }
}

- (void)iapManagerDidFailToAcquireProduct:(NSString *)productIdentifier withTransactionType:(GBIAP2TransactionType)transactionType transactionState:(GBIAP2TransactionState)transactionState solicited:(BOOL)solicited {
    NSString *transactionTypeString;
    switch (transactionType) {
        case GBIAP2TransactionTypeUnknown: {
            transactionTypeString = @"Unknown";
        } break;
            
        case GBIAP2TransactionTypePurchase: {
            transactionTypeString = @"Purchase";
        } break;
            
        case GBIAP2TransactionTypeRePurchase: {
            transactionTypeString = @"RePurchase";
        } break;
            
        case GBIAP2TransactionTypeRestore: {
            transactionTypeString = @"Restore";
        } break;
    }
    
    NSString *transactionStateString;
    switch (transactionState) {
        case GBIAP2TransactionStateUnknown: {
            transactionStateString = @"Unknown";
        } break;
            
        case GBIAP2TransactionStateSuccess: {
            transactionStateString = @"Success";
        } break;
            
        case GBIAP2TransactionStateCancelled: {
            transactionStateString = @"Cancelled";
        } break;
            
        case GBIAP2TransactionStateFailed: {
            transactionStateString = @"Failed";
        } break;
    }
    
    [GBAnalytics trackEvent:@"GBIAP2: Failed to acquired product" withParameters:@{@"product": Stringify(productIdentifier), @"transactionType": transactionTypeString, @"transactionState": transactionStateString, @"solicited": _b(solicited), @"jailbroken": _b(self.isJailbroken)}];
}

@end
