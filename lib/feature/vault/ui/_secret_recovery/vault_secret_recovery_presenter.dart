import 'package:get_it/get_it.dart';

import 'package:guardian_keyper/feature/message/domain/entity/message_model.dart';

import '../../domain/entity/secret_shard.dart';
import '../../domain/use_case/vault_interactor.dart';
import '../vault_secret_presenter_base.dart';

export 'package:provider/provider.dart';

class VaultSecretRecoveryPresenter extends VaultSecretPresenterBase {
  VaultSecretRecoveryPresenter({
    required super.pageCount,
    required super.vaultId,
    required super.secretId,
  }) {
    // fill messages with request
    for (final guardian in vault.guardians.keys) {
      messages.add(MessageModel(
        peerId: guardian,
        code: MessageCode.getShard,
        status: guardian == vault.ownerId
            ? MessageStatus.accepted
            : MessageStatus.created,
        payload: SecretShard(
          id: secretId,
          ownerId: _vaultInteractor.selfId,
          vaultId: vaultId,
          groupSize: vault.maxSize,
          groupThreshold: vault.threshold,
          shard: guardian == vault.ownerId ? vault.secrets[secretId]! : '',
        ),
      ));
    }
    _vaultInteractor.logStartRestoreSecret();
  }

  String get secret => _secret;

  bool get isObfuscated => _isObfuscated;

  int get needAtLeast => vault.threshold - (vault.isSelfGuarded ? 1 : 0);

  @override
  void responseHandler(MessageModel message) async {
    final updatedMessage = checkAndUpdateMessage(message, MessageCode.getShard);
    if (updatedMessage == null) return;
    if (messages.where((m) => m.isAccepted).length >= vault.threshold) {
      stopListenResponse();
      _vaultInteractor.logFinishRestoreSecret();
      _secret = await _vaultInteractor.restoreSecret(messages
          .where((e) => e.secretShard.shard.isNotEmpty)
          .map((e) => e.secretShard.shard)
          .toList());
      requestCompleter.complete(updatedMessage);
      nextPage();
    } else if (messages.where((e) => e.isRejected).length > vault.redudancy) {
      stopListenResponse();
      requestCompleter.complete(updatedMessage.copyWith(
        status: MessageStatus.rejected,
      ));
    } else {
      notifyListeners();
    }
  }

  void onPressedHide() {
    _isObfuscated = true;
    notifyListeners();
  }

  bool tryShow() {
    if (_isAuthorized) {
      _isObfuscated = false;
      notifyListeners();
      return true;
    }
    return false;
  }

  void onUnlockedShow() {
    _isObfuscated = false;
    _isAuthorized = true;
    notifyListeners();
  }

  Future<bool> tryCopy() async {
    if (_isAuthorized) {
      return _vaultInteractor.copyToClipboard(secret);
    }
    return false;
  }

  Future<bool> onUnlockedCopy() {
    _isAuthorized = true;
    notifyListeners();
    return tryCopy();
  }

  // Private
  final _vaultInteractor = GetIt.I<VaultInteractor>();

  String _secret = '';
  bool _isObfuscated = true;
  bool _isAuthorized = false;
}
