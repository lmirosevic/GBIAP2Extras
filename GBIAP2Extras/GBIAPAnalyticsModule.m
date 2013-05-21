//
//  GBIAPAnalyticsModule.m
//  GBIAPExtras
//
//  Created by Luka Mirosevic on 21/05/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import "GBIAPAnalyticsModule.h"

#import "GBAnalytics.h"

//foo what happens with my analytics when the dict element is a list? might have to coerce it into a string
//both flurry and google?

@implementation GBIAPAnalyticsModule

-(void)iapManagerDidResumeTransactions {
    _t(@"GBIAP2: Resumed transactions");
}

-(void)iapManagerDidRegisterValidationServers:(NSArray *)servers {
    _td(@"GBIAP2: Registered validation servers", @{@"servers": servers});
}

-(void)iapManagerUserDidRequestMetadataForProducts:(NSArray *)productIdentifiers {
    _td(@"GBIAP2: Requested metadata", @{@"products": productIdentifiers});
}

-(void)iapManagerUserDidRequestPurchaseForProduct:(NSString *)productIdentifier {
    _td(@"GBIAP2: Requested purchase", @{@"product": productIdentifier});
}

-(void)iapManagerUserDidRequestRestore {
    _t(@"GBIAP2: Requested restore");
}

-(void)iapManagerDidBeginMetadataFetchForProducts:(NSArray *)productIdentifiers {
    _td(@"GBIAP2: Began metadata fetch", @{@"products": productIdentifiers});
}

-(void)iapManagerDidEndMetadataFetchForProducts:(NSArray *)productIdentifiers state:(GBIAP2MetadataFetchState)state {
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
    
    _td(@"GBIAP2: Ended metadata fetch", @{@"products": productIdentifiers, @"state": stateString});
}

-(void)iapManagerDidBeginPurchaseForProduct:(NSString *)productIdentifier {
    _td(@"GBIAP2: Began purchase phase", @{@"product": productIdentifier});
}

-(void)iapManagerDidEndPurchaseForProduct:(NSString *)productIdentifier state:(GBIAP2PurchaseState)state solicited:(BOOL)solicited {
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
    
    NSString *solicitedString = solicited ? @"YES" : @"NO";
    
    _td(@"GBIAP2: Ended purchase phase", @{@"product": productIdentifier, @"state": stateString, @"solicited": solicitedString});
}

-(void)iapManagerDidBeginRestore {
    _t(@"GBIAP2: Began restore");
}

-(void)iapManagerDidEndRestoreForProduct:(NSString *)productIdentifier state:(GBIAP2PurchaseState)state solicited:(BOOL)solicited {
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
    
    NSString *solicitedString = solicited ? @"YES" : @"NO";
    
    _td(@"GBIAP2: Ended restore phase for product", @{@"product": productIdentifier, @"state": stateString, @"solicited": solicitedString});
}

-(void)iapManagerDidBeginVerificationForProduct:(NSString *)productIdentifier onServer:(NSString *)server {
    _td(@"GBIAP2: Began verification phase", @{@"product": productIdentifier, @"server": server});
}

-(void)iapManagerDidEndVerificationForProduct:(NSString *)productIdentifier onServer:(NSString *)server state:(GBIAP2VerificationState)state {
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
    
    _td(@"GBIAP2: Ended verification phase", @{@"product": productIdentifier, @"server": server, @"state": stateString});
}

-(void)iapManagerDidSuccessfullyAcquireProduct:(NSString *)productIdentifier withTransactionType:(GBIAP2TransactionType)transactionType transactionState:(GBIAP2TransactionState)transactionState solicited:(BOOL)solicited {
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
    
    NSString *solicitedString = solicited ? @"YES" : @"NO";
    
    _td(@"GBIAP2: Successfully acquired product", @{@"product": productIdentifier, @"transactionType": transactionTypeString, @"transactionState": transactionStateString, @"solicited": solicitedString});
    
    //Break them down again because Flurry and Google Analytics ain't that great
    if (transactionType == GBIAP2TransactionTypePurchase) {
        _td(@"GBIAP2: Actually purchased", @{@"product": productIdentifier, @"solicited": solicitedString});
    }
    else if (transactionType == GBIAP2TransactionTypeRePurchase) {
        _td(@"GBIAP2: Actually repurchased", @{@"product": productIdentifier, @"solicited": solicitedString});
    }
    else if (transactionType == GBIAP2TransactionTypeRestore) {
        _td(@"GBIAP2: Actually restored", @{@"product": productIdentifier, @"solicited": solicitedString});
    }
}

-(void)iapManagerDidFailToAcquireProduct:(NSString *)productIdentifier withTransactionType:(GBIAP2TransactionType)transactionType transactionState:(GBIAP2TransactionState)transactionState solicited:(BOOL)solicited {
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
    
    NSString *solicitedString = solicited ? @"YES" : @"NO";
    
    _td(@"GBIAP2: Failed to acquired product", @{@"product": productIdentifier, @"transactionType": transactionTypeString, @"transactionState": transactionStateString, @"solicited": solicitedString});
}

@end
