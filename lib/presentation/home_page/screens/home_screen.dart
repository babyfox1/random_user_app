import 'package:flutter/material.dart';
import 'package:random_user_app/data/models/users_params_model.dart';
import 'package:random_user_app/data/repositories/get_users_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> genderItems = ['male', 'female'];
  List<int> countItem = [];
  String selectedValue = 'male';
  int selectedCount = 5;
  @override
  void initState() {
    initCountList();
    super.initState();
  }

  void initCountList() {
    for (var i = 5; i < 101; i++) {
      if (i % 5 == 0) {
        countItem.add(i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('RandomUser'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              DropdownButton<String>(
                value: selectedValue,
                items:
                    genderItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (val) {
                  selectedValue = val ?? '';
                  setState(() {});
                },
              ),
              DropdownButton(
                value: selectedCount,
                items: countItem.map((e) {
                  return DropdownMenuItem(value: e, child: Text(e.toString()));
                }).toList(),
                onChanged: (val) {
                  selectedCount = val ?? 0;
                  setState(() {});
                },
              ),
              Expanded(
                  child: FutureBuilder(
                      future: GetUsersRepository().getUsers(
                        model: UsersParamsModel(
                          results: selectedCount,
                          gender: selectedValue,
                        ),
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                              width: 100,
                              height: 100,
                              child:
                                  const CircularProgressIndicator.adaptive());
                        }
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data?.results?.length,
                            itemBuilder: (context, index) => SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.network(
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.error),
                                snapshot.data?.results?[index].picture?.large ??
                                    '',
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
