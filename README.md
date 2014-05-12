OpenTok 2.2 iOS SDK Beta 3
==========================

The OpenTok iOS 2.2 SDK Beta 3 includes the following new features:

* OTPublisherKitDelegate messages that indicate when publisher's stream has
  started or stopped being recorded to an archive. (See "New API in 2.2" below.)
  The OpenTok 2.0 archiving feature is in beta. For more information, see
  <http://www.tokbox.com/blog/opentok-2-0-archiving-playback/>.

This SDK interoperates with apps that use the following client SDKs:

* OpenTok.js 2.2

* OpenTok Android SDK 2.2 Beta

This version of the OpenTok iOS SDK supports the armv7 architectures
only. Remove the other architectures from your build settings.

This is a beta version. The API may change in upcoming releases.

Using the SDK
-------------

The OpenTok.framework directory contains the OpenTok iOS 2.2 SDK.

The OpenTok 2.2 SDK requires Xcode 5.

Sample apps
-----------

See the iOS-SDK-Cookbook directory for sample apps that show how to use
the API.

Documentation
-------------

Reference documentation is at
<http://www.tokbox.com/opentok/libraries/client/ios/2.2/reference/index.html>.

Known issues
------------

This version of the OpenTok iOS SDK is currently compiling for only the armv7
architecture. Remove other architectures from your build settings. This does
not affect the availability to any iOS devices. However, you will not be able
to run your application in the simulator.

Changes to the existing (2.1) API
---------------------------------

### Changes in Beta 3:

* The initializer for the OTSession object now includes an API key parameter:

        [OTSession initWithApiKey:sessionId:delegate:]

* The method to connect to a session no longer includes the API key as a parameter

        [OTSession connectWithToken:error:]

* Error parameters have been added to the following methods:

        [OTSession connectWithToken:error]
        [OTSession publish:error]
        [OTSession signalWithType:string:connection:error]
        [OTSession subscribe:error]
        [OTSession unpublish:error]
        [OTSession unsubscribe:error]

  If there is a synchronous error in calling the method, the error
  object is set to an OTError object; otherwise it is set to NULL.

  For example, the following code checks for a synchronous error when
  calling `[OTSession subscribe:error]`:

        OTError* myError = nil;
        [_session subscribe:_subscriber error:&myError]
        if (myError) {
          NSLog(@"subscribe failed with error: (%@)", myError);
        }

* You no longer need to add the Xcode -ObjC flag to the "Other Linker Flags"
  build setting. The OpenTok 2.2 iOS SDK no longer requires it.

### Changes in Beta 2:

* Signaling API -- To send a signal, use the following messages:

        [OTSession signalWithType:string:connection:error:]
  
  This method takes a connection parameter that is either a single OTConnection
  object (not an array) or nil (to send a signal to all clients in the session).
  
  Completion blocks for signaling have been removed. If sending a signal
  fails, the error object passed into the signal methods is set to an
  OTError object. The OTSessionErrorCode enum (in OTError.h) includes
  OTSessionInvalidSignalType and OTSessionSignalDataTooLong constants for
  these errors.

  Receiving a signal has been implemented in the following delegate methods:
  
        [OTSession receivedSignalType:connection:string:]

  The following methods (in which the data is set as an object) have been
  removed:

        [OTSession signalWithType:object:connections:error:]
        [OTSession receivedSignalType:connection:withObject:]

* The OTSubscriberDelegate protocol has been renamed OTSubscriberKitDelegate.

* Updated subscriber workflow -- In the OpenTok 2.1 iOS SDK, an OTSubscriber 
  immediately begins subscribing when you call its init method. The OpenTok 2.2
  iOS SDK provides a finer level of object control with the 
  `[OTSession subscribe:]` and `[OTSession unsubscribe:]` methods. After object
  initialization, pass the instance to your session to begin subscribing.

* Some messages in the OTSessionDelegate methods have been renamed:
  
  `[OTSessionDelegate didReceiveStream]` is now 
  [`OTSessionDelegate streamCreated:]`
  
  `[OTSessionDelegate didDropStream]` is now
  `[OTSessionDelegate streamDestroyed:]`

New API in 2.2
--------------

### Added in Beta 3

The `[OTPublisherKitDelegate publisher:archivingStatusChanged:]` message is sent
when an archive starts or stops recording the publisher's stream. You may want
to add or remove a user interface element indicating that recording has started
or stopped, based on this message.

### Added in Beta 1

The following new classes support the new custom video stream API:

* OTPublisherKit--Use this class to use a custom video capturer and video
renderer for an audio-video stream to publish to an OpenTok session. Note that
the OTPublisher class, which uses the iOS camera as a direct video feed, is a
subclass of OTPublisherKit.

* OTSubscriberKit--Use this class to use a custom video renderer for an
audio-video stream. Note that the OTSubscriber class, which displays the video
stream unaltered, is a subclass of OTSubscriberKit.

* OTVideoCapture--Use this interface is to provide video data to an 
OTPublisherKit object.

* OTVideoRender--Use this interface is to render video data in an 
OTPublisherKit object or OTSubscriberKit object.

* Other classes and enums related to the custom video stream API are defined
in the OTVideoKit.h file.

Other changes:

* The new [OTSessionDelegate didAddPublisher:] is sent when you start 
  publishing a stream to a session using OTPublisherKit. The new 
  [OTSessionDelegate didRemovePublisher:] is sent when you stop publishing
  a stream to a session using OTPublisherKit. (Note that OTPublisher is a 
  subclass of OTPublisherKit, so these delegate messages apply to OTPublisher 
  as well.)

* New OTSession.apiQueue property--The delegate callback queue is now 
  application-definable. The GCD queue for issuing callbacks to the delegate
  may be overridden to allow integration with XCTest (new in Xcode 5) or
  other frameworks that need the to operate in (and block) the main thread.

* The enums in the OTError.h file have new values assigned. The error code
  values correspond to the values in the OpenTok JavaScript 2.2 SDK.

The OpenTok iOS 2.2 SDK Beta 3 also includes these new features:

* Support for Apple AirPlay.

* Support for TURN over TCP -- This improves connectivity in restricted network
  environments. Only ports 80 and 443 are required. For more information see
  <http://www.tokbox.com/blog/opentok-now-supports-turn-over-tcp/>.

More information
----------------

If you have feedback or questions, please write <denis@tokbox.com>.
