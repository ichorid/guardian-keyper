import 'package:get_it/get_it.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entity/vault.dart';
import '../../domain/entity/vault_id.dart';
import '../../domain/use_case/vault_interactor.dart';

export 'package:provider/provider.dart';

class VaultHomePresenter extends ChangeNotifier {
  VaultHomePresenter() {
    // cache vaults
    for (final vault in _vaultInteractor.vaults) {
      if (vault.ownerId == _vaultInteractor.selfId) _myVaults[vault.id] = vault;
    }
    // init subscription
    _vaultChanges.resume();
  }

  Map<VaultId, Vault> get myVaults => _myVaults;

  @override
  void dispose() {
    _vaultChanges.cancel();
    super.dispose();
  }

  final _myVaults = <VaultId, Vault>{};
  final _vaultInteractor = GetIt.I<VaultInteractor>();

  late final _vaultChanges = _vaultInteractor.watch().listen((event) {
    if (event.isDeleted) {
      _myVaults.removeWhere((_, v) => v.aKey == event.key);
    } else if (event.vault!.ownerId == _vaultInteractor.selfId) {
      _myVaults[event.vault!.id] = event.vault!;
    }
    notifyListeners();
  });
}
