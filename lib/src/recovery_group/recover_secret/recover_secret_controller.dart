import 'package:sss256/sss256.dart';

import '/src/core/model/core_model.dart';
import '/src/core/service/analytics_service.dart';

import '../recovery_group_controller.dart';

class RecoverySecretController extends RecoveryGroupSecretController {
  RecoverySecretController({
    required super.diContainer,
    required super.pagesCount,
    required super.groupId,
    required super.secretId,
  }) {
    // fill messages with request
    for (final guardian in group.guardians.keys) {
      messages.add(MessageModel(
        peerId: guardian,
        code: MessageCode.getShard,
        payload: SecretShardModel(
          id: secretId,
          ownerId: diContainer.myPeerId,
          groupId: groupId,
          groupSize: group.maxSize,
          groupThreshold: group.threshold,
          shard: '',
        ),
      ));
    }
  }

  bool get hasMinimal => messagesWithSuccess.length >= group.threshold;

  String get secret {
    diContainer.analyticsService.logEvent(eventFinishRestoreSecret);
    return restoreSecret(
      shares: messages.map((e) => e.secretShard.shard).toList(),
    );
  }

  void startRequest({required Callback onRejected}) {
    diContainer.analyticsService.logEvent(eventStartRestoreSecret);
    networkSubscription = networkStream.listen(
      (message) {
        if (message.code != MessageCode.getShard) return;
        if (!message.hasResponse) return;
        if (!messages.contains(message)) return;
        updateMessage(message);
        if (messagesWithResponse.length == group.maxSize) stopListenResponse();
        if (messagesNotSuccess.length > group.redudancy) onRejected(message);
      },
    );
    startNetworkRequest(requestShards);
  }
}