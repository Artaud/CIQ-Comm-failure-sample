//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.Application as App;
using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Sensor as Sensor;
using Toybox.Timer as Timer;

var page = 0;
var strings = ["","","","",""];
var stringsSize = 5;
var mailMethod;
var phoneMethod;
var crashOnMessage = false;

var dataTimer;
var info;
const SAMPLE_PERIOD = 5000; //ms

class CommExample extends App.AppBase {

    function initialize() {
        App.AppBase.initialize();
        Comm.registerForPhoneAppMessages(method(:onPhone));
    }

    // onStart() is called on application start up
    function onStart(state) {
        dataTimer = new Timer.Timer();
        dataTimer.start( method(:timerCallback), SAMPLE_PERIOD, true);
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
        dataTimer = null;
        mailMethod = null;
        phoneMethod = null;
        info = null;
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [new CommView(), new CommInputDelegate()];
    }

    function onPhone(msg) {
        var i;

        if((crashOnMessage == true) && msg.data.equals("Hi")) {
//            foo = bar;
        }

        for(i = (stringsSize - 1); i > 0; i -= 1) {
            strings[i] = strings[i-1];
        }
        strings[0] = msg.data.toString();
        page = 1;

        Ui.requestUpdate();
    }

    function timerCallback() {

        info = Sensor.getInfo();

        var listener = new CommListener();
        Comm.transmit(info.accel, null, listener);

    }

}