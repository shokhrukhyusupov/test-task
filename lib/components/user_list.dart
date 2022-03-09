import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:junior_task/bloc/post_bloc/post_bloc.dart';
import '../bloc/user_bloc/user_bloc.dart';
import '../bloc/user_bloc/user_state.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  int isTapped = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserLoadedState) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.users.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () {
                  isTapped = i;
                  BlocProvider.of<PostBloc>(context)
                      .loadPost(state.users[i].id, i - 1);
                  setState(() {});
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: isTapped == i ? Colors.white : Colors.blueGrey,
                    borderRadius: BorderRadius.circular(5),
                    border: isTapped == i
                        ? Border.all(color: Colors.white, width: 3)
                        : null,
                    boxShadow: isTapped == i
                        ? [
                            const BoxShadow(
                                blurRadius: 1, color: Colors.blueGrey)
                          ]
                        : null,
                  ),
                  child: SizedBox.square(
                    dimension: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/avataaars/avataaars(${state.users[i].id}).png'),
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          state.users[i].name,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color:
                                isTapped == i ? Colors.blueGrey : Colors.white,
                            fontWeight: isTapped == i
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                          textScaleFactor: MediaQuery.of(context)
                              .textScaleFactor
                              .clamp(1, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      } else if (state is UserLoadFailedState) {
        return Center(child: Text(state.exception));
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
