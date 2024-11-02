import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodapp/view/screens/chat/widgets/chat_repository.dart';

final chatProvider = Provider(
  (ref) => ChatRepository(),
);
