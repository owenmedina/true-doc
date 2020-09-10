import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:provider/provider.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

import '../constants/strings_constants.dart';
import '../providers/auth.dart';
import '../widgets/forms/call_form.dart';

class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  String _roomText = 'test';
  String _userDisplayName;
  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
      onConferenceWillJoin: _onConferenceWillJoin,
      onConferenceJoined: _onConferenceJoined,
      onConferenceTerminated: _onConferenceTerminated,
      onError: _onError,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  dynamic _onConferenceWillJoin({Map<dynamic, dynamic> message}) {
    print(
        'Global meeting event onConferenceWillJoin. \nData: ${message['url']}');
  }

  dynamic _onConferenceJoined({Map<dynamic, dynamic> message}) {
    print('Global meeting event onConferenceJoined. \nData: ${message['url']}');
  }

  dynamic _onConferenceTerminated({Map<dynamic, dynamic> message}) {
    print(
        'Global meeting event onConferenceTerminated. \nData: ${message['url']}');
  }

  dynamic _onError(dynamic message) {
    print('Global meeting event onError. \nData: ${message}');
  }

  _joinMeeting() async {
    try {
      // list of feature flags
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
        FeatureFlagEnum.ADD_PEOPLE_ENABLED: false,
        FeatureFlagEnum.INVITE_ENABLED: false,
      };

      // disable call integration on Android because it's buggy
      if (Platform.isAndroid) {
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      // Define meetings options
      var options = JitsiMeetingOptions()
        ..room = _roomText
        ..serverURL = null // Falls back to https://meet.jit.si
        ..subject = ''
        ..userDisplayName = _userDisplayName
        ..userEmail = ''
        ..audioOnly = false
        ..audioMuted = false
        ..videoMuted = false
        ..featureFlags.addAll(featureFlags);
      print('JitsiMeetingOptions: $options');

      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(
          onConferenceWillJoin: ({message}) {
            print(
                'Single meeting onConferenceWillJoin. \n${options.room} will join with message: $message');
          },
          onConferenceJoined: ({message}) {
            print(
                'Single meeting onConferenceJoined. \n${options.room} will join with message: $message');
          },
          onConferenceTerminated: ({message}) {
            print(
                'Single meeting onConferenceTerminated. \n${options.room} will join with message: $message');
          },
          onError: (message) {
            print(
                'Single meeting onError. \n${options.room} will join with message: $message');
          },
        ),
      );
    } catch (e) {
      print('Caught error in call_screen._joinMeeting(): $e');
    }
  }

  void _submitHandler(String channelName, String displayName) {
    _roomText = channelName;
    _userDisplayName = displayName;
    print('Entered _submitHandler() with _roomText: ${_roomText} and _userDisplayName: ${_userDisplayName}');
    _joinMeeting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(StringConstants.meetingScreenTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          CallForm(_submitHandler),
        ],
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}
