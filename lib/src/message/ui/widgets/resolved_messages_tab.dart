import '/src/core/widgets/common.dart';

import '../message_presenter.dart';
import 'message_list_tile.dart';

class ResolvedMessagesTab extends StatelessWidget {
  const ResolvedMessagesTab({super.key});

  @override
  Widget build(final BuildContext context) {
    final messages = context.watch<MessagesPresenter>().resolvedMessages;
    return messages.isEmpty
        ? Center(
            child: Text(
              'You don’t have any resolved messages',
              textAlign: TextAlign.center,
              style: textStyleSourceSansPro414,
              softWrap: true,
            ),
          )
        : ListView(
            children: messages
                .map((e) => Padding(
                      padding: paddingV6,
                      child: MessageListTile(message: e),
                    ))
                .toList(),
          );
  }
}
