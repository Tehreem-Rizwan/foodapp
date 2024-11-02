// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:foodapp/constants/app_colors.dart';
// import 'package:foodapp/view/screens/chat/chat.dart';
// import 'package:foodapp/view/screens/chat/providers/get_user_info_by_id_provider.dart';
// import 'package:intl/intl.dart';

// class ChatTile extends ConsumerWidget {
//   const ChatTile({
//     Key? key,
//     required this.userId,
//     required this.lastMessage,
//     required this.lastMessageTs,
//     required this.chatroomId,
//   }) : super(key: key);

//   final String userId;
//   final String lastMessage;
//   final DateTime lastMessageTs;
//   final String chatroomId;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Fetch user info by ID
//     final userInfo = ref.watch(getUserInfoByIdProvider(userId));

//     return userInfo.when(
//       data: (user) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//           child: InkWell(
//             onTap: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => ChatScreen(userId: userId),
//                 ),
//               );
//             },
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 30,
//                   backgroundImage: NetworkImage(
//                     user.profilePicUrl.isNotEmpty
//                         ? user.profilePicUrl
//                         : 'assets/images/placeholder.png', // Local asset placeholder
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         user.fullName,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       Row(
//                         children: [
//                           Flexible(
//                             child: Text(
//                               lastMessage,
//                               style: const TextStyle(color: kTertiaryColor),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           const SizedBox(width: 5),
//                           Text(
//                             DateFormat('hh:mm a').format(lastMessageTs),
//                             style: const TextStyle(color: kTertiaryColor),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 10),
//                   child: Icon(
//                     Icons.check_circle_outline,
//                     color: kTertiaryColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//       error: (error, stackTrace) =>
//           Center(child: Text('Error: ${error.toString()}')),
//       loading: () => const Center(child: CircularProgressIndicator()),
//     );
//   }
// }
