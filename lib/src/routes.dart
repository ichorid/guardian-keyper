import 'package:flutter/material.dart';

import 'core/model/core_model.dart';

import 'start_view.dart';
import 'intro/intro_view.dart';
import 'home/home_view.dart';
import 'recovery_group/add_secret/add_secret_view.dart';
import 'recovery_group/create_group/create_group_view.dart';
import 'recovery_group/add_guardian/add_guardian_view.dart';
import 'recovery_group/restore_group/restore_group_view.dart';
import 'recovery_group/edit_group/recovery_group_edit_view.dart';
import 'recovery_group/recover_secret/recover_secret_view.dart';

Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) =>
    MaterialPageRoute<void>(
      settings: routeSettings,
      builder: (BuildContext context) {
        switch (routeSettings.name) {
          case IntroView.routeName:
            return const IntroView();

          case HomeView.routeName:
            return const HomeView();

          case CreateGroupView.routeName:
            return const CreateGroupView();

          case RecoveryGroupEditView.routeName:
            return RecoveryGroupEditView(
              groupId: routeSettings.arguments as GroupId,
            );

          case AddGuardianView.routeName:
            return AddGuardianView(
              groupId: routeSettings.arguments as GroupId,
            );

          case RecoveryGroupAddSecretView.routeName:
            return RecoveryGroupAddSecretView(
              groupId: routeSettings.arguments as GroupId,
            );

          case RecoveryGroupRecoverSecretView.routeName:
            return RecoveryGroupRecoverSecretView(
              groupIdWithSecretId:
                  routeSettings.arguments as MapEntry<GroupId, SecretId>,
            );

          case RestoreGroupView.routeName:
            return RestoreGroupView(
              skipExplainer: routeSettings.arguments as bool,
            );

          default:
            return const StartView();
        }
      },
    );
