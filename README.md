# Asset Cache Tool

[![GitHub Workflow](https://github.com/mysticlgbt/asset-cache-tool/actions/workflows/macos.yml/badge.svg)](https://github.com/mysticlgbt/asset-cache-tool/actions/workflows/macos.yml)
[![Latest macOS Build](https://shields.io/badge/download-macOS%20nightly-blue)](https://nightly.link/mysticlgbt/asset-cache-tool/workflows/macos/main/asset-cache-tool.zip)
[![Latest Linux Build](https://shields.io/badge/download-Linux%20nightly-blue)](https://nightly.link/mysticlgbt/asset-cache-tool/workflows/linux/main/asset-cache-tool.zip)
[![Latest Release](https://shields.io/github/v/release/mysticlgbt/asset-cache-tool?display_name=tag&sort=semver)](https://github.com/mysticlgbt/asset-cache-tool/releases/latest)

A library and tool for interacting with both the local and remote asset caches.

This is based on [research](https://github.com/azenla/AppleCache) I did a few years ago on the Apple Asset Cache (Content Cache) system.

## Usage

### Install Latest with Homebrew

1. Install [Homebrew](https://brew.sh)
2. Install asset-cache-tool with Homebrew: `brew install mysticlgbt/made/asset-cache-tool`

### Install Nightly With Mint

1. Install Mint: `brew install mint`
2. Install asset-cache-tool with Mint: `mint install mysticlgbt/asset-cache-tool@main`

### Run with SwiftPM

1. Clone the source: `git clone https://github.com/mysticlgbt/asset-cache-tool.git asset-cache-tool`
2. Switch to source directory: `cd asset-cache-tool`
3. Run asset-cache-tool with SwiftPM: `swift run asset-cache-tool`

## Commands

### list-local-assets

List assets inside the local cache.

```bash
$ swift run asset-cache-tool list-local-assets
92F10AA2-A516-48EE-8A8F-16521B4B12D9 namespace=default index=unknown uri=/ios10.0/031-96898-20170613-6B3C72AA-4FA3-11E7-8777-44F3D6EEE68A/com_apple_MobileAsset_MediaSupport/a6741b0690cf20ecf4600b2249df9accf6e00690.zip
```

### reassemble-local-cache

Reassemble cached files in the local cache into a clean structure.

```bash
$ swift run asset-cache-tool reassemble-local-cache
Copy EF628FF9-639F-4700-A269-0874AA2DBCF7 -> cache/2021FCSFall/patches/002-21830/64B33144-0546-426F-9AC1-A032B2A934E0/com_apple_MobileAsset_SoftwareUpdate/a0dcd05ecac842606be647f9627bf5b1c5a7fdae.zip
```

### print-local-cache-path

Print the default local cache path.

```bash
$ swift run asset-cache-tool print-local-cache-path
/Volumes/MyCacheDrive/Library/Application Support/Apple/AssetCache/Data
```

### find-local-caches

Find caches that are located on the current system.

```bash
$ swift run asset-cache-tool find-local-caches
/Volumes/MyCacheDrive/Library/Application Support/Apple/AssetCache/Data
```

### find-remote-caches

Find caches that are located on the network.

```bash
$ swift run asset-cache-tool find-remote-caches -l 10.0.15.1
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
$ swift run asset-cache-tool download-remote-cache --remote-cache-url 'http://10.0.15.1:8950' 'https://appldnld.apple.com/myfile.zip' 'myfile.zip'
```

### cache-registration-configuration

Fetch the cache registration configuration.

```bash
$ swift run asset-cache-tool cache-registration-configuration
{"registrationURL":"https:\/\/lcdn-registration.apple.com\/lcdn\/register","certificateURL":"https:\/\/lcdn-registration.apple.com\/resource\/cert.cer","allowListedHosts":["swcdn.apple.com:80","swcdn.apple.com:443","validation.isu.apple.com:80","validation.isu.apple.com:443","appldnld.apple.com:80","oscdn.apple.com:80","oscdn.apple.com:443","swdist.apple.com:443","swdownload.apple.com:80","swdownload.apple.com:443","audiocontentdownload.apple.com:80","audiocontentdownload.apple.com:443","deimos.apple.com:80","deimos3.apple.com:80","basejumper.apple.com:80","basejumper.apple.com:443","playgrounds-assets-cdn.apple.com:443","playgrounds-cdn.apple.com:443","updates.cdn-apple.com:443","updates-http.cdn-apple.com:80","sylvan.apple.com:80","sylvan.apple.com:443","devimages-cdn.apple.com:80","devimages-cdn.apple.com:443","download.developer.apple.com:80","download.developer.apple.com:443"],"denyListURL":"http:\/\/suconfig.apple.com\/resource\/registration\/v1\/denylist.plist","whiteListedHosts":["swcdn.apple.com:80","swcdn.apple.com:443","validation.isu.apple.com:80","validation.isu.apple.com:443","appldnld.apple.com:80","oscdn.apple.com:80","oscdn.apple.com:443","swdist.apple.com:443","swdownload.apple.com:80","swdownload.apple.com:443","audiocontentdownload.apple.com:80","audiocontentdownload.apple.com:443","deimos.apple.com:80","deimos3.apple.com:80","basejumper.apple.com:80","basejumper.apple.com:443","playgrounds-assets-cdn.apple.com:443","playgrounds-cdn.apple.com:443","updates.cdn-apple.com:443","updates-http.cdn-apple.com:80","sylvan.apple.com:80","sylvan.apple.com:443","devimages-cdn.apple.com:80","devimages-cdn.apple.com:443","download.developer.apple.com:80","download.developer.apple.com:443"],"deregistrationURL":"https:\/\/lcdn-registration.apple.com\/lcdn\/deregister","whiteListedDomains":["phobos.apple.com:80","itunes.apple.com:80","itunes.apple.com:443","assets.itunes.com:80","assets.itunes.com:443"],"statisticsURL":"https:\/\/xp-cdn.apple.com\/report\/2\/xp_cdn_receipt","allowListedDomains":["phobos.apple.com:80","itunes.apple.com:80","itunes.apple.com:443","assets.itunes.com:80","assets.itunes.com:443"],"assetTypeMap":[{"map":[{"type":"swdist"}],"host":["swdist.apple.com"]},{"map":[{"type":"swdownload"}],"host":["swdownload.apple.com"]},{"map":[{"type":"swcdn"}],"host":["swcdn.apple.com"]},{"map":[{"type":"oscdn"}],"host":["oscdn.apple.com"]},{"map":[{"type":"validation"}],"host":["validation.isu.apple.com"]},{"map":[{"type":"appldnld"}],"host":["appldnld.apple.com"]},{"map":[{"type":"basejumper"}],"host":["basejumper.apple.com"]},{"map":[{"type":"playgrounds"}],"host":["playgrounds-assets-cdn.apple.com","playgrounds-cdn.apple.com"]},{"map":[{"type":"sylvan"}],"host":["sylvan.apple.com"]},{"map":[{"type":"dev"}],"host":["devimages-cdn.apple.com","download.developer.apple.com"]},{"map":[{"type":"gbnd"}],"host":["audiocontentdownload.apple.com"]},{"map":[{"type":"odr"}],"host":["odr.assets.itunes.com","odr.itunes.apple.com"]},{"map":[{"type":"itunesu"}],"host":["p1-u.itunes.apple.com","p2-u.itunes.apple.com","deimos.apple.com","deimos3.apple.com","itunesu.assets.itunes.com","itunesu.itunes.apple.com","itunesu-assets.itunes.apple.com"]},{"map":[{"type":"Apps","path":["\/*\/Purple*\/*.zip","\/*\/Purple*\/*.pkg","\/*\/Purple*\/*.ipa"]},{"type":"iBooks","path":["\/*\/Publication*\/*"]},{"type":"Movies","path":["\/*\/Video\/*f.m4v","\/*\/Video\/*f.mov"]},{"type":"Songs","path":["\/*\/Features\/*.m4p","\/*\/Features\/*.m4a","\/*\/Features\/*.mp4","\/*\/Music\/*.m4p","\/*\/Music\/*.m4a","\/*\/Music\/*.mp4"]},{"type":"itunesu","path":["\/*\/Cobalt*"]}],"host":["*.phobos.apple.com","*.v.phobos.apple.com","*.assets.itunes.com","books.itunes.apple.com","iosapps.itunes.apple.com","osxapps.itunes.apple.com"]},{"map":[{"type":"icloud","namespace":["icloud"],"path":["n\/a"]}],"host":["*"]}],"mediaTypeMap":[{"type":"iCloud","path":["n\/a"]},{"type":"iTunes U","path":["\/*\/Cobalt*","\/WebObjects\/Core.woa\/Download*","\/WebObjects\/Core.woa\/Feed*","\/WebObjects\/Core.woa\/Subscription*"]},{"type":"Books","path":["*.epub","*.ibooks"]},{"type":"Apple TV Software","path":["*[aA]pple[tT][vV]*","*tv[oO][sS]*","*\/Videos\/*.[mM][oO][vV]"]},{"type":"iOS Software","path":["*.ipa","*.ipd","*.ipsw","*.assetpack","\/ios*","\/iOS*"]},{"type":"Mac Software","path":["*.pkg","*.dmg"]},{"type":"Movies","path":["*.m4v","*.mov"]},{"type":"Music","path":["*.m4p","*.m4a","*.mp4"]},{"type":"Other"}],"blackListURL":"http:\/\/suconfig.apple.com\/resource\/registration\/v1\/blacklist.plist","establishmentURL":"https:\/\/lcdn-registration.apple.com\/lcdn\/session"}
```
