import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

import '../models/app_user.dart';
import '../services/auth.dart';
import '../services/calls.dart';
import '../utilities/constants/strings_constants.dart';
import '../widgets/forms/call_form.dart';

class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  String _roomText;
  String _userDisplayName;
  AppUser _callee;
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

      final response = await JitsiMeet.joinMeeting(
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

      if (response.isSuccess) {
        final currentUserId = Auth.currentUserId;
        final physicianId = _callee.type == UserType.physician ? _callee.id : currentUserId; // TODO: consider setting listen to false in the Provider<Auth>
        final patientId = _callee.type == UserType.patient ? _callee.id : currentUserId; // TODO: consider setting listen to false in the Provider<Auth>
        Calls().createCall(physicianId, patientId);
      }
    } catch (e) {
      print('Caught error in call_screen._joinMeeting(): $e');
    }
  }

  void _submitHandler(String channelName, String displayName, AppUser callee) {
    _roomText = channelName;
    _userDisplayName = displayName;
    _callee = callee;
    print('Entered _submitHandler() with _roomText: $_roomText and _userDisplayName: $_userDisplayName');
    _joinMeeting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(StringConstants.callScreenTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Auth.logout();
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
