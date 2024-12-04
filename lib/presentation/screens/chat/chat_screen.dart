import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding:  EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://i.pinimg.com/736x/74/b0/f8/74b0f8e53df07ed298a3d3e425f8b56f.jpg'),
          ),
        ),
        title: const Text('Mi amor ❤️'),
        centerTitle: true,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final chatProvider= context.watch<ChatProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child:ListView.builder(
                controller: chatProvider.chatScrollController,
                itemCount: chatProvider.messageList.length,
              itemBuilder: (context, index) {
                final message= chatProvider.messageList[index];
                return (message.fromWho==FromWho.hers)
                ? HerMessageBubble(message: message)
                : MyMessageBubble( message: message);
              }) 
              ),
          MessageFieldBox(
            //onValue: (value) => chatProvider.sendMessage(value) Esta es una forma de hacer lo de abajo, hacen la misma función
            onValue: chatProvider.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}