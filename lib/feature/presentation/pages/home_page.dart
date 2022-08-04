import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_firebase/feature/presentation/cubit/note/note_cubit.dart';

import '../../../app_const.dart';
import '../cubit/authen/auth_cubit.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //todo:3
  @override
  void initState() {
    BlocProvider.of<NoteCubit>(context).getNotes(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MyNotes ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).loggedOut();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, noteState) {
          if (noteState is NoteLoaded) {
            print("Todo loaded");
            return _bodyWidget(noteState);
          }
          if (noteState is NoteLoading) {
            print("Todo loading");
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
          print("Todo load failed");
          return const Center(
            child: Text('Loaded Failed'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, PageConst.kAddNotePage,
              arguments: widget.uid);
        },
      ),
    );
  }

  Widget _noNotesWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 80.0,
          child: Image.network(
            "https://raw.githubusercontent.com/amirk3321/my-notes-app/main/assets/notebook.png",
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Text('No notes here yet'),
      ],
    );
  }

  Widget _bodyWidget(NoteLoaded noteLoadedState) {
    return Column(
      children: [
        Expanded(
          child: noteLoadedState.notes.isEmpty
              ? _noNotesWidget()
              : GridView.builder(
                  itemCount: noteLoadedState.notes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PageConst.kUpDateNotePage,
                            arguments: noteLoadedState.notes[index]);
                      },
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Delete Note"),
                              content: const Text(
                                  "Are you sure you want to delete this note?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    BlocProvider.of<NoteCubit>(context)
                                        .deleteNotes(
                                            noteEntity:
                                                noteLoadedState.notes[index]);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Delete"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("No"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 2.0,
                                spreadRadius: 2.0,
                                offset: const Offset(0, 1.5),
                              ),
                            ]),
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${noteLoadedState.notes[index].note}",
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              DateFormat("dd MMM yyy hh:mm a").format(
                                  noteLoadedState.notes[index].time!.toDate()),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
