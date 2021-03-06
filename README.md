![AM](http://i.imgur.com/CEEbHaw.gif)
=================================
> A personal as3 library

[![build status][travis_build_status_image]][travis_build_status_url]

To clone this project (and all its submodules):

    git clone --recursive git://github.com/adriancmiranda/as3.git

## Dependencies
### Config constants
    
    CONFIG::SUBMODULE (boolean)
    CONFIG::FLASH_10_1 (boolean)
    CONFIG::WEB (boolean)
    CONFIG::AIR (boolean)

### Submodule dependency
* [com.am.core.ApplicationLoader][ApplicationLoader]
    *   [com.greensock.events.LoaderEvent][LoaderEvent]
    *   [com.greensock.loading.core.LoaderCore][LoaderCore]
    *   [com.greensock.loading.core.LoaderItem][LoaderItem]
    *   [com.greensock.loading.LoaderMax][LoaderMax]
    *   [com.greensock.loading.MP3Loader][MP3Loader]
    *   [com.greensock.loading.LoaderStatus][LoaderStatus]
    *   [com.greensock.plugins.TweenPlugin][TweenPlugin]
* [com.am.display.ThumbnailMax][ThumbnailMax]
    *   [com.greensock.events.LoaderEvent][LoaderEvent]
    *   [com.greensock.loading.core.LoaderCore][LoaderCore]
* [com.am.display.ThumbnailLite][ThumbnailLite]
    *   [com.greensock.events.LoaderEvent][LoaderEvent]
    *   [com.greensock.loading.core.LoaderCore][LoaderCore]
* [com.am.utils.ObjectHelper][ObjectHelper]
    *   [com.adobe.serialization.json.JSON][JSON]
* [com.am.core.Analytics][Analytics]
    *   [com.google.analytics.AnalyticsTracker][AnalyticsTracker]
    *   [com.google.analytics.GATracker][GATracker]

### Submodules
* [AS3 Core Lib][as3corelib]
* [SWF Object][swfobject]
* [SWF Address][swfaddress]
* [GA for Flash][gaforflash]
* [Greensock][greensock]

Support
=======

Bugs and issues should be reported via the [issue tracker][issue_tracker].

[sample]: https://github.com/adriancmiranda/flash-compiler/tree/master/examples/web "web"
[issue_tracker]: http://github.com/adriancmiranda/as3/issues "Issue tracker"

[travis_build_status_image]: https://travis-ci.org/adriancmiranda/as3.png?branch=master
[travis_build_status_url]: https://travis-ci.org/adriancmiranda/as3 "build status"

[ApplicationLoader]: https://github.com/adriancmiranda/as3/blob/master/source/com/am/core/ApplicationLoader.as "com.am.core.ApplicationLoader"
[ThumbnailMax]: https://github.com/adriancmiranda/as3/blob/master/source/com/am/display/ThumbnailMax.as "com.am.display.ThumbnailMax"
[ThumbnailLite]: https://github.com/adriancmiranda/as3/blob/master/source/com/am/display/ThumbnailLite.as "com.am.display.ThumbnailLite"
[ObjectHelper]: https://github.com/adriancmiranda/as3/blob/master/source/com/am/utils/ObjectHelper.as "com.am.utils.ObjectHelper"
[Analytics]: https://github.com/adriancmiranda/as3/blob/master/source/com/am/core/Analytics.as "com.am.core.Analytics"

[greensock]: https://github.com/greensock/GreenSock-AS3
[LoaderEvent]: https://github.com/greensock/GreenSock-AS3/blob/master/src/com/greensock/events/LoaderEvent.as "com.greensock.events.LoaderEvent"
[LoaderCore]: https://github.com/greensock/GreenSock-AS3/blob/master/src/com/greensock/loading/core/LoaderCore.as "com.greensock.loading.core.LoaderCore"
[LoaderItem]: https://github.com/greensock/GreenSock-AS3/blob/master/src/com/greensock/loading/core/LoaderItem.as "com.greensock.loading.core.LoaderItem"
[LoaderMax]: https://github.com/greensock/GreenSock-AS3/blob/master/src/com/greensock/loading/LoaderMax.as "com.greensock.loading.LoaderMax"
[MP3Loader]: https://github.com/greensock/GreenSock-AS3/blob/master/src/com/greensock/loading/MP3Loader.as "com.greensock.loading.MP3Loader"
[LoaderStatus]: https://github.com/greensock/GreenSock-AS3/blob/master/src/com/greensock/loading/LoaderStatus.as "com.greensock.loading.LoaderStatus"
[TweenPlugin]: https://github.com/greensock/GreenSock-AS3/blob/master/src/com/greensock/plugins/TweenPlugin.as "com.greensock.plugins.TweenPlugin"

[as3corelib]: https://github.com/mikechambers/as3corelib "AS3 Core Lib"
[JSON]: https://github.com/mikechambers/as3corelib/blob/master/src/com/adobe/serialization/json/JSON.as "com.adobe.serialization.json.JSON"

[swfobject]: https://github.com/swfobject/swfobject

[swfaddress]: https://github.com/robwalch/swfaddress

[gaforflash]: https://code.google.com/p/gaforflash/ "Google Analytics for flash"
[AnalyticsTracker]: https://code.google.com/p/gaforflash/source/browse/trunk/src/com/google/analytics/AnalyticsTracker.as "com.google.analytics.AnalyticsTracker"
[GATracker]: https://code.google.com/p/gaforflash/source/browse/trunk/src/com/google/analytics/GATracker.as?r=193 "com.google.analytics.GATracker"

<!-- helpers -->

[Writing A Better Object]: http://rtmpserver.com/wp-content/uploads/2012/04/huw_column1.pdf
