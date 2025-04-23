# FLFeatureRequest

## Usage

### Show list
```
FeatureListView()
```

### Set the user id
```
FLFeatureRequest.updateUser(customID: String)
```

### Set the StoreKit product a user has purchased
```
FLFeatureRequest.setPurchase(userID: String, product: SKProduct)
```

### Override the default Firebase APIs
```
FLFeatureRequest.configure(api: FLFeatureRequestApiInterface)
```
