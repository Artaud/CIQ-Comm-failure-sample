# CIQ-Comm-failure-sample

## What does this repo show:

These are slightly modified Comm samples from CIQ SDK 2.2.5 and CIQ Android Mobile SDK v1.4.

They are to show how easy is to get to the point where any attempt at communication phone => watch results in FAILURE_DURING_TRANSFER, while in the other direction messages go through normally.


The phone Comm sample has been modified only by adding a logger that logs any messages (beginnings of..) sent to the watch, along with the message status, as follows:

```
05-24 17:55:18.223 23371-23371/com.garmin.android.apps.connectiq.sample.comm I/onListItemClick: Hello Worl SUCCESS
05-24 17:53:24.116 23371-23371/com.garmin.android.apps.connectiq.sample.comm I/onListItemClick: Lorem ipsu FAILURE_DURING_TRANSFER
```

The watch Comm sample has been modified by adding a timer that periodically polls the accelerometric sensor and sends the data via Comm.transmit to the phone.
Period of the timer is set by

`const SAMPLE_PERIOD = 5000; //ms`

## Steps to reproduce:

1. Install & run both of the apps
2. On Android, tap on your connected device to select it. The app will now start receiving messages from watch.
3. Try to send any message to the watch and check the Android log. You'll get FAILURE_DURING_TRANSFER very early.
4. Turn off the app on watch and try to send any message from the phone now. Normally, you should get SUCCESS even if the app is not running, but now you get FAILURE_DURING_TRANSFER forever.
