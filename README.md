ActionScript (β) [![build status][travis_build_status_image]][travis_build_status_url]
=================================

To clone this project (and all its submodules):

    git clone --recursive git://github.com/adriancmiranda/actionscript.git

## Dependencies
### Config constants
    
    CONFIG::SUBMODULE (boolean)
    CONFIG::FLASH_10_1 (boolean)
    CONFIG::WEB (boolean)
    CONFIG::AIR (boolean)

### Submodule dependency
* [com.am.display.ThumbnailMax][ThumbnailMax]
	*   [LoaderEvent][LoaderEvent]
	*   [LoaderCore][LoaderCore]
* [com.am.display.ThumbnailLite][ThumbnailLite]
	*   [LoaderEvent][LoaderEvent]
	*   [LoaderCore][LoaderCore]
* [com.am.utils.ObjectHelper][ObjectHelper]
	*   [JSON][JSON]

### Submodules
* [AS3 Core Lib][as3corelib]
* [SWF Address][swfaddress]
* [GA for Flash][gaforflash]
* [Greensock][greensock]

Support
=======

Bugs and issues should be reported via the [issue tracker][issue_tracker].

[issue_tracker]: http://github.com/adriancmiranda/actionscript/issues "Issue tracker"

[travis_build_status_image]: https://travis-ci.org/adriancmiranda/actionscript.png?branch=master
[travis_build_status_url]: https://travis-ci.org/adriancmiranda/actionscript "build status"

[ThumbnailMax]: https://github.com/adriancmiranda/actionscript/blob/master/source/com/am/display/ThumbnailMax.as "com.am.display.ThumbnailMax"
[ThumbnailLite]: https://github.com/adriancmiranda/actionscript/blob/master/source/com/am/display/ThumbnailLite.as "com.am.display.ThumbnailLite"
[ObjectHelper]: https://github.com/adriancmiranda/actionscript/blob/master/source/com/am/utils/ObjectHelper.as "com.am.utils.ObjectHelper"

[greensock]: https://github.com/greensock/GreenSock-AS3
[LoaderEvent]: https://github.com/greensock/GreenSock-AS3/blob/master/src/com/greensock/events/LoaderEvent.as "com.greensock.events.LoaderEvent"
[LoaderCore]: https://github.com/greensock/GreenSock-AS3/blob/master/src/com/greensock/loading/core/LoaderCore.as "com.greensock.loading.core.LoaderCore"

[as3corelib]: https://github.com/mikechambers/as3corelib "AS3 Core Lib"
[JSON]: https://github.com/mikechambers/as3corelib/blob/master/src/com/adobe/serialization/json/JSON.as "com.adobe.serialization.json.JSON"

[swfaddress]: https://github.com/robwalch/swfaddress

[gaforflash]: https://code.google.com/p/gaforflash/ "Google Analytics for flash"
[AnalyticsTracker]: https://code.google.com/p/gaforflash/source/browse/trunk/src/com/google/analytics/AnalyticsTracker.as "com.google.analytics.AnalyticsTracker"
[GATracker]: https://code.google.com/p/gaforflash/source/browse/trunk/src/com/google/analytics/GATracker.as?r=193 "com.google.analytics.GATracker"
