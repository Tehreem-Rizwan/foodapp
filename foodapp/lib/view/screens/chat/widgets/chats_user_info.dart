import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/view/screens/chat/providers/get_user_info_by_id_provider.dart';
import 'package:foodapp/view/screens/chat/widgets/error_scree.dart';
import 'package:foodapp/view/widget/Custom_text_widget.dart';

class ChatUserInfo extends ConsumerWidget {
  const ChatUserInfo({
    super.key,
    required this.userId,
  });

  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      getUserInfoByIdProvider(userId),
    );

    return userInfo.when(
      data: (user) {
        return Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(user.profilePicUrl),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: user.fullName,
                  size: 18,
                  weight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
                CustomText(
                  text: 'Messenger',
                  size: 14,
                  color: kgreyblackColor,
                )
              ],
            ),
          ],
        );
      },
      error: (error, stackTrace) {
        return ErrorScreen(error: error.toString());
      },
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }
}
