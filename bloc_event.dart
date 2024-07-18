// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'bloc_bloc.dart';

@immutable
sealed class BlocEvent {}

class ChatGenerationNewTextMessageEvent extends BlocEvent {
  final String inputMessage;
  ChatGenerationNewTextMessageEvent({
    required this.inputMessage,
  });
}
