import 'package:belajar_api/service/user_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic>? data;
  String? messageError;

  void getApi() async {
    data?.clear();
    try {
      data = await UserService.getUser();

      setState(() {});
    } catch (e) {
      messageError = e.toString();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Visibility(
              visible: data?.isNotEmpty == true,
              child: Text(data?.getRange(0, 3).toList().toString() ?? ""),
            ),
            Text(messageError.toString()),
            ElevatedButton(
              onPressed: () async {
                getApi();
              },
              child: const Text(
                'Test Api',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
