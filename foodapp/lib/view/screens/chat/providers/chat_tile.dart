import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodapp/constants/app_colors.dart';
import 'package:foodapp/constants/extensions.dart';
import 'package:foodapp/view/screens/chat/providers/get_user_info_by_id_provider.dart';

class ChatTile extends ConsumerWidget {
  const ChatTile({
    Key? key,
    required this.userId,
    required this.lastMessage,
    required this.lastMessageTs,
    required this.chatroomId,
  }) : super(key: key);

  final String userId;
  final String lastMessage;
  final DateTime lastMessageTs;
  final String chatroomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch user info by ID
    final userInfo = ref.watch(getUserInfoByIdProvider(userId));

    return userInfo.when(
      data: (user) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: InkWell(
            onTap: () {
              // Navigate to the ChatScreen when tapping on a chat tile
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    userId: userId,
                    chatroomId: chatroomId,
                  ),
                ),
              );
            },
            child: Row(
              children: [
                // Profile Picture
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(user.profilePicUrl),
                ),
                const SizedBox(width: 10),
                // Column for Name, Last Message, and Timestamp
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User's Name
                      Text(
                        user.fullName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Last Message and Timestamp
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              lastMessage,
                              style: const TextStyle(color: kTertiaryColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Text(' → '),
                          Text(
                            lastMessageTs.jm(),
                            style: const TextStyle(color: kTertiaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Message Status Icon
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.check_circle_outline,
                    color: kTertiaryColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Container(
          width: double.infinity,
          height: 50,
          color: Colors.grey,
          child: Center(child: Text('Error: ${error.toString()}')),
        );
      },
      loading: () {
        return Container(
          width: double.infinity,
          height: 50,
          color: Colors.grey,
        );
      },
    );
  }
}
