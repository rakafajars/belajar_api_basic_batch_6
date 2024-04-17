import 'package:belajar_api/model/user_model.dart';
import 'package:belajar_api/service/user_service.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get User Api'),
      ),
      body: FutureBuilder(
        future: UserService.getUser(),
        builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, int index) {

                return ListTile(
                  title: Text(
                    snapshot.data?[index].name ?? "-",
                  ),
                  subtitle: Text(
                    snapshot.data?[index].phone ?? "-",
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
