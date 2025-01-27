import 'package:get_it/get_it.dart';

import 'package:guardian_keyper/data/network_manager.dart';
import 'package:guardian_keyper/domain/entity/peer_id.dart';
import 'package:guardian_keyper/feature/vault/domain/entity/vault.dart';
import 'package:guardian_keyper/feature/vault/domain/entity/vault_id.dart';
import 'package:guardian_keyper/feature/settings/data/settings_manager.dart';

import '../../data/message_repository.dart';
import '../entity/message_model.dart';
import 'message_ingress_mixin.dart';
import 'message_egress_mixin.dart';

typedef MessageEvent = ({String key, MessageModel? value, bool isDeleted});

class MessageInteractor with MessageIngressMixin, MessageEgressMixin {
  MessageInteractor() {
    _networkManager.messageStream.listen(onMessage);
  }

  late final flush = _messageRepository.flush;
  late final pingPeer = _networkManager.pingPeer;
  late final getPeerStatus = _networkManager.getPeerStatus;

  PeerId get selfId => _settingsManager.selfId;

  Iterable<MessageModel> get messages => _messageRepository.values;

  @override
  Future<void> archivateMessage(MessageModel message) async {
    await _messageRepository.delete(message.aKey);
    await _messageRepository.put(
      message.timestamp.millisecondsSinceEpoch.toString(),
      message,
    );
  }

  Stream<MessageEvent> watch() =>
      _messageRepository.watch().map<MessageEvent>((e) => (
            key: e.key as String,
            value: e.value as MessageModel?,
            isDeleted: e.deleted,
          ));

  /// Create ticket to join vault
  Future<MessageModel> createJoinVaultCode() async {
    final message = MessageModel(
      code: MessageCode.createGroup,
      peerId: _settingsManager.selfId,
    );
    await _messageRepository.put(message.aKey, message);
    return message;
  }

  /// Create ticket to take vault
  Future<MessageModel> createTakeVaultCode(VaultId? groupId) async {
    final message = MessageModel(
      code: MessageCode.takeGroup,
      peerId: _settingsManager.selfId,
    );
    await _messageRepository.put(
      message.aKey,
      message.copyWith(
        payload: Vault(id: groupId, ownerId: PeerId.empty),
      ),
    );
    return message;
  }

  Future<void> pruneMessages() async {
    await _messageRepository.deleteAll(_messageRepository.values
        .where((e) => e.isForPrune)
        .map((e) => e.aKey));
    await _messageRepository.compact();
  }

  // Private
  final _networkManager = GetIt.I<NetworkManager>();
  final _settingsManager = GetIt.I<SettingsManager>();
  final _messageRepository = GetIt.I<MessageRepository>();
}
