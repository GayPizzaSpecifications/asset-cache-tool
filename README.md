# AssetCacheTool

Apple Asset Cache Utilities

## Commands

### list

List assets in the cache.

```
$ swift run AssetCacheTool list
92F10AA2-A516-48EE-8A8F-16521B4B12D9 namespace=default index=unknown uri=/ios10.0/031-96898-20170613-6B3C72AA-4FA3-11E7-8777-44F3D6EEE68A/com_apple_MobileAsset_MediaSupport/a6741b0690cf20ecf4600b2249df9accf6e00690.zip
```

### reassemble

Reassemble cached assets into a cleaner directory structure.

```
$ swift run AssetCacheTool reassemble
Copy EF628FF9-639F-4700-A269-0874AA2DBCF7 -> cache/2021FCSFall/patches/002-21830/64B33144-0546-426F-9AC1-A032B2A934E0/com_apple_MobileAsset_SoftwareUpdate/a0dcd05ecac842606be647f9627bf5b1c5a7fdae.zip
```
