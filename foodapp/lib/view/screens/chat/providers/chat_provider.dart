import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodapp/view/screens/chat/chat_repository.dart';

final chatProvider = Provider(
  (ref) => ChatRepository(),
);
