ActionScript (in development yet) [![build status][travis_build_status_image]][travis_build_status_url]
=================================

To clone this project (and all its submodules):

    git clone --recursive git://github.com/adriancmiranda/actionscript.git

## Dependencies:
### Config constants
    
    CONFIG::SUBMODULE (boolean)
    CONFIG::FLASH_10_1 (boolean)
    CONFIG::WEB (boolean)
    CONFIG::AIR (boolean)

### Classes with dependences:
* [ThumbnailMax][ThumbnailMax]
*   import com.greensock.events.LoaderEvent;
	import com.greensock.loading.core.LoaderCore;
* [ThumbnailLite][ThumbnailLite]
* [ObjectHelper][ObjectHelper]

[travis_build_status_image]: https://travis-ci.org/adriancmiranda/actionscript.png?branch=master
[travis_build_status_url]: https://travis-ci.org/adriancmiranda/actionscript "build status"

[ThumbnailMax]: https://github.com/adriancmiranda/actionscript/blob/master/source/com/am/display/ThumbnailMax.as
[ThumbnailLite]: https://github.com/adriancmiranda/actionscript/blob/master/source/com/am/display/ThumbnailLite.as
[ObjectHelper]: https://github.com/adriancmiranda/actionscript/blob/master/source/com/am/utils/ObjectHelper.as
