# AssetCacheTool

Apple Asset Cache Utilities

## Commands

### list-local-assets

List assets inside the local cache.

```bash
$ swift run AssetCacheTool list-local-assets
92F10AA2-A516-48EE-8A8F-16521B4B12D9 namespace=default index=unknown uri=/ios10.0/031-96898-20170613-6B3C72AA-4FA3-11E7-8777-44F3D6EEE68A/com_apple_MobileAsset_MediaSupport/a6741b0690cf20ecf4600b2249df9accf6e00690.zip
```

### reassemble-local-cache

Reassemble cached files in the local cache into a clean structure.

```bash
$ swift run AssetCacheTool reassemble-local-cache
Copy EF628FF9-639F-4700-A269-0874AA2DBCF7 -> cache/2021FCSFall/patches/002-21830/64B33144-0546-426F-9AC1-A032B2A934E0/com_apple_MobileAsset_SoftwareUpdate/a0dcd05ecac842606be647f9627bf5b1c5a7fdae.zip
```

### print-local-cache-path

Print the default local cache path.

```bash
$ swift run AssetCacheTool print-local-cache-path
/Volumes/MyCacheDrive/Library/Application Support/Apple/AssetCache/Data
```

### find-local-caches

Find caches that are located on the current system.

```bash
$ swift run AssetCacheTool find-local-caches
/Volumes/MyCacheDrive/Library/Application Support/Apple/AssetCache/Data
```
