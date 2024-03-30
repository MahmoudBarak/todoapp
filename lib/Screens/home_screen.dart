import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/Cubit/AppCubit/app_cubit.dart';
import 'package:todoapp/Cubit/AppCubit/app_state.dart';
import 'package:todoapp/CustomWidgets/custom_floating_button.dart';
import 'package:todoapp/Screens/add_data_screen.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
  builder: (context, state) {
    if(state is GetData){
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        iconData: Icons.add,
        VoidCallback: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => const AddDataScreen(),
              ),
              (route) => false);
        },
      ),
        bottomNavigationBar: bottom() ,
      appBar: AppBar(
        title: const Text('To Do List'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          if (BlocProvider.of<AppCubit>(context).data.isNotEmpty)
          for (int i = 0;
          i < min(BlocProvider.of<AppCubit>(context).tasksPerPage, (BlocProvider.of<AppCubit>(context).data.length - (BlocProvider.of<AppCubit>(context).currentPage * BlocProvider.of<AppCubit>(context).tasksPerPage))); i++)
            Padding(padding: const EdgeInsets.all(10),child:  task(BlocProvider.of<AppCubit>(context).data[
            (BlocProvider.of<AppCubit>(context).currentPage *
                BlocProvider.of<AppCubit>(context).tasksPerPage) +
                i]) ,)


        ],
      )),
    );
    }
    return CircularProgressIndicator();

  },
);
  }



  task(Map model) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.grey.shade300),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            radius: 45,
            child: Text(
              '${model['time']}',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 60,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['task']}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text('${model['date']}'),
            ],
          )
        ],
      ),
    );
  }
  bottom(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),

        if (BlocProvider.of<AppCubit>(context).data.isNotEmpty)
          Text(
            'Page ${BlocProvider.of<AppCubit>(context).currentPage + 1} of ${(BlocProvider.of<AppCubit>(context).data.length / BlocProvider.of<AppCubit>(context).tasksPerPage).ceil()}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //first page button
            BlocProvider.of<AppCubit>(context).startPage > 0 &&
                (MediaQuery.of(context).size.width  / 90).floor() <
                    (BlocProvider.of<AppCubit>(context).data.length / BlocProvider.of<AppCubit>(context).tasksPerPage).ceil()
                ? SizedBox(
              width: 24,
              child: IconButton(
                  icon: const Icon(Icons.first_page),
                  onPressed: () {
                    setState(() {
                      BlocProvider.of<AppCubit>(context).startPage = 0;
                      BlocProvider.of<AppCubit>(context).currentPage = 0;
                    });
                  }),
            )
                : const SizedBox(),
            //move backward button
            BlocProvider.of<AppCubit>(context). startPage > 0 &&
                (MediaQuery.of(context).size.width / 90).floor() <
                    (BlocProvider.of<AppCubit>(context).data.length / BlocProvider.of<AppCubit>(context).tasksPerPage).ceil()
                ? SizedBox(
              width: 30,
              child: IconButton(
                icon: const Icon(Icons.navigate_before),
                onPressed: () {
                  setState(() {
                    BlocProvider.of<AppCubit>(context). startPage--;
                  });
                },
              ),
            )
                : const SizedBox(),
            //numbered page buttons
            for (int i =BlocProvider.of<AppCubit>(context). startPage;
            i <
                min(
                    ((MediaQuery.of(context).size.width  / 50)
                        .floor() +
                        BlocProvider.of<AppCubit>(context).startPage),
                    (BlocProvider.of<AppCubit>(context).data.length / BlocProvider.of<AppCubit>(context).tasksPerPage).ceil());
            i++)
              SizedBox(
                width: 30,
                height: 40,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor:
                  BlocProvider.of<AppCubit>(context).currentPage == i ? Colors.amber : Colors.white,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        BlocProvider.of<AppCubit>(context).currentPage= i;
                      });
                    },
                    child: Text(
                      (i + 1).toString(),
                    ),
                  ),
                ),
              ),
            //move forward button
            (BlocProvider.of<AppCubit>(context).data.length / BlocProvider.of<AppCubit>(context).tasksPerPage).ceil() >
                (MediaQuery.of(context).size.width  / 90)
                    .floor() &&
                ((BlocProvider.of<AppCubit>(context).data.length / BlocProvider.of<AppCubit>(context).tasksPerPage).ceil() -
                    BlocProvider.of<AppCubit>(context).startPage) >
                    (MediaQuery.of(context).size.width / 90)
                        .floor()
                ? SizedBox(
              width:24,
              child: IconButton(
                  icon: const Icon(Icons.navigate_next),
                  onPressed: () {
                    setState(() {
                      BlocProvider.of<AppCubit>(context).startPage++;
                    });
                  }),
            )
                : const SizedBox(),
            //last page button
            (BlocProvider.of<AppCubit>(context).data.length / BlocProvider.of<AppCubit>(context).tasksPerPage).ceil() >
                (MediaQuery.of(context).size.width  / 90)
                    .floor() &&
                ((BlocProvider.of<AppCubit>(context).data.length / BlocProvider.of<AppCubit>(context).tasksPerPage).ceil() -
                    BlocProvider.of<AppCubit>(context).startPage) >
                    (MediaQuery.of(context).size.width /90)
                        .floor()
                ? IconButton(
              icon: const Icon(Icons.last_page),
              onPressed: () {
                setState(() {
                  BlocProvider.of<AppCubit>(context).startPage = (BlocProvider.of<AppCubit>(context).data.length / BlocProvider.of<AppCubit>(context).tasksPerPage)
                      .ceil() -
                      (MediaQuery.of(context).size.width  / 90)
                          .floor();
                  BlocProvider.of<AppCubit>(context).currentPage =
                      (BlocProvider.of<AppCubit>(context).data.length / BlocProvider.of<AppCubit>(context).tasksPerPage).ceil() - 1;
                });
              },
            )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }
}
