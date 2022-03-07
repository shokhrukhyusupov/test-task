import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_task/bloc/user_bloc.dart';
import 'package:junior_task/bloc/user_state.dart';
import 'package:junior_task/pages/tasks_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.transparent,
              labelPadding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.02),
              tabs: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blueAccent),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blueAccent),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blueAccent),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blueAccent),
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoadedState) {
              return TabBarView(
                children: [
                  ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text('post: ${state.users[i].id}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TasksPage(user: state.users[i]),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text('post: ${state.users[i].id}'),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text('post: ${state.users[i].id}'),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text('post: ${state.users[i].id}'),
                      );
                    },
                  ),
                ],
              );
            } else if (state is UserLoadFailedState) {
              return Center(
                child: Text(
                  state.exception,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'Ты Криворукий',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
