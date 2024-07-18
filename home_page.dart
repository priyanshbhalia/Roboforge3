import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_ai/bloc/bloc_bloc.dart';
import 'package:gemini_ai/models/chat_message_model.dart';
import 'package:lottie/lottie.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BlocBloc chatBloc = BlocBloc();
  TextEditingController textEditingController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BlocBloc, BlocState>(
        bloc: chatBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
              List<ChatMessageModel> messages =
                  (state as ChatSuccessState).messages;
              return Container(
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.5,
                        image: AssetImage("assets/wallpaper.jpg"),
                        fit: BoxFit.cover)),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "RoboForge",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 28),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.image_search,
                                color: Colors.white,
                              ))
                        ],
                      ),
                      // color: Colors.red,
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: EdgeInsets.only(bottom: 12),
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.amber.withOpacity(0.1)),
                                  child:
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          
                                          Row(
                                            children: [
                                             
                                              Text(messages[index].role=="user"?"User":"RoboForge AI",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: messages[index].role == "user"? Color.fromARGB(255, 163, 201, 104):Colors.blueAccent),),
                                            ],
                                          ),
                                            SizedBox(height: 10,),
                                        
                                              
                                              Text(messages[index].parts.first.text,
                                              style: TextStyle(
                                                fontSize: 15
                                              ),),
                                            
                                        ],
                                      ));
                            })),
                       if (chatBloc.loader==true)
                      Container(
                        height: 100,
                        width: 100,
                        child: Lottie.asset('assets/loader.json')),
                           
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 25, horizontal: 16),
                      height: 120,
                      // color: Colors.blue,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textEditingController,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 24),
                              cursorColor: Theme.of(context).primaryColor,
                             
                              
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  fillColor: Colors.white,
                                  
                                  hintText: "Message RoboForge...",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                      ))),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          InkWell(
                            onTap: () {
                              if (textEditingController.text.isNotEmpty) {
                                String text = textEditingController.text;
                                textEditingController.clear();
                                chatBloc.add(ChatGenerationNewTextMessageEvent(
                                    inputMessage: text));
                              }
                            },
                            child: CircleAvatar(
                              radius: 38,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: const Center(
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
