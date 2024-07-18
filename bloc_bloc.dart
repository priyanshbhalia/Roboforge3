import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gemini_ai/models/chat_message_model.dart';
import 'package:gemini_ai/repos/chat_repo.dart';
import 'package:meta/meta.dart';

part 'bloc_event.dart';
part 'bloc_state.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  BlocBloc() : super(ChatSuccessState(messages: [])) {
    // on<BlocEvent>((event, emit) {
    //   // TODO: implement event handler
    // });
    on<ChatGenerationNewTextMessageEvent>(chatGenerationNewTextMessageEvent);
  }
  List<ChatMessageModel> messages = [];
  bool loader = false;

  FutureOr<void> chatGenerationNewTextMessageEvent(
      ChatGenerationNewTextMessageEvent event, Emitter<BlocState> emit) async {
    messages.add(ChatMessageModel(
        role: "user", parts: [ChatPartModel(text: event.inputMessage)]));
    emit(ChatSuccessState(messages: messages));
    loader=true;

    String generatedText = await ChatRepo.chatTextGenerationRepo(messages);
    if (generatedText.length > 0) {
      messages.add(ChatMessageModel(
          role: 'model', parts: [ChatPartModel(text: generatedText)]));
      emit(ChatSuccessState(messages: messages));
    }
    loader = false;
  }
}
