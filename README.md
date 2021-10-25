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

### find-remote-caches

Find caches that are located on the network.

```bash
$ swift run AssetCacheTool find-remote-caches -l 10.0.15.1
GUID: 48B1475B-C221-43E6-967B-5802A2A795AB
  Address: 10.0.15.1
  Port: 8950
  Version: 243
  Rank: 1
  Cache Size: 80 GB
```

### download-remote-cache

Download a file from a remote cache.

```bash
$ swift run AssetCacheTool download-remote-cache --remote-cache-url 'http://10.0.15.1:8950' 'https://appldnld.apple.com/myfile.zip' 'myfile.zip'
```
