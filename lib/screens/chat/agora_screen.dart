import 'package:flutter/material.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class AgoraScreen extends StatefulWidget {
  final types.Room room;
  AgoraScreen({Key? key, required this.room}) : super(key: key);

  @override
  State<AgoraScreen> createState() => _AgoraScreenState();
}

class _AgoraScreenState extends State<AgoraScreen> {
  late final AgoraClient client;

  @override
  void initState() {
    super.initState();

    initAgora();
  }

  void initAgora() async {
    client = AgoraClient(
      enabledPermission: [Permission.camera, Permission.microphone],
      agoraConnectionData: AgoraConnectionData(
        appId: "857b6e44dd344b0986ba9863c72d246e",
        channelName: widget.room.id,
        username: "user",
      ),
    );

    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Agora VideoUIKit'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(
              client: client,
              layoutType: Layout.floating,
              showAVState: true,

              enableHostControls: true, // Add this to enable host controls
            ),
            AgoraVideoButtons(
              client: client,
            ),
          ],
        ),
      ),
    );
  }
}
