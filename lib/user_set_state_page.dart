import 'package:belajar_api/model/user_model.dart';
import 'package:belajar_api/service/user_service.dart';
import 'package:flutter/material.dart';

class UserSetStatePage extends StatefulWidget {
  const UserSetStatePage({super.key});

  @override
  State<UserSetStatePage> createState() => _UserSetStatePageState();
}

class _UserSetStatePageState extends State<UserSetStatePage> {
  List<UserModel> _listUser = [];
  String? _errorMessage;
  bool _isLoading = false;

  void getUser() async {
    _isLoading = true;
    _listUser.clear();
    _errorMessage = null;
    setState(() {});
    try {
      _listUser = await UserService.getUser();
      setState(() {});
    } catch (e) {
      _errorMessage = e.toString();

      setState(() {});
    } finally {
      _isLoading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  Widget bodyScreen() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (_errorMessage != null) {
      return Center(
        child: Column(
          children: [
            Text(
              _errorMessage ?? "-",
            ),
            ElevatedButton(
              onPressed: () {
                getUser();
              },
              child: const Text(
                'Refresh',
              ),
            )
          ],
        ),
      );
    } else {
      return RefreshIndicator(
        onRefresh: () async => getUser(),
        child: ListView.builder(
          itemCount: _listUser.length,
          itemBuilder: (context, int index) {
            return ListTile(
              title: Text(
                _listUser[index].name ?? "-",
              ),
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Api Set State'),
      ),
      body: bodyScreen(),
    );
  }
}
