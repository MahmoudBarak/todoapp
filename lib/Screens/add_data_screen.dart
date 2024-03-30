import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/Cubit/AppCubit/app_cubit.dart';
import 'package:todoapp/Cubit/AppCubit/app_state.dart';
import 'package:todoapp/CustomWidgets/custom_floating_button.dart';
import 'package:todoapp/CustomWidgets/custom_text_form_field.dart';
import 'package:todoapp/Screens/home_screen.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final TextEditingController _date = TextEditingController();
  final TextEditingController _time = TextEditingController();
  final TextEditingController _task = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool validateForm() {
    final form = formKey.currentState;
    return form!.validate() ? true : false;
  }
done(){
  if(validateForm()){
    BlocProvider.of<AppCubit>(context).insertIntoDataBase(task: _task.text, time: _time.text, date: _date.text);
}
}
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {
    if(state is DataInsertSuccess){
      ScaffoldMessenger.of(context).showSnackBar(  SnackBar(content: const Text('Data Insert Success',style: TextStyle(color: Colors.black),),backgroundColor: Colors.grey.shade200,));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) =>const  HomeScreen(),
          ),
              (route) => false);


    }
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        leading:  IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) =>const  HomeScreen(),
                  ),
                      (route) => false);
            },
            icon: const Icon(Icons.arrow_back_outlined)),
        title:const  Text('Add Task'),
      ),
     floatingActionButton: CustomFloatingActionButton(iconData: Icons.done,VoidCallback: done,),
     body: SafeArea(
      child: Form(
      key: formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        reverse: true,
        child: Column(
          children: [
            CustomTFD(
              label: 'Task',
              controller: _task,
              type: TextInputType.name,
              action: TextInputAction.next,
              VoidCallback: (task) =>
              task!.isEmpty ? " Task Can’t be Empty" : null,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 60,
            ),
            CustomTFD(
              onTap: (){
                showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
                  _time.text=value!.format(context).toString();
                } );
              },
              label: 'Time',
              controller: _time,
              type: TextInputType.datetime,
              action: TextInputAction.next,
              VoidCallback: (time) =>
              time!.isEmpty ? " Time Can’t be Empty" : null,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 60,
            ),
            CustomTFD(
              onTap: (){
                showDatePicker(context: context,initialDate: DateTime.now(), firstDate: DateTime.now(),lastDate: DateTime(2100)).then((value)  {
                  _date.text=value.toString().substring(0,[10].first);
                });
              },
              func: (_){
                done();
              },
              type: TextInputType.text,
              action: TextInputAction.done,
              label: 'date',
              controller: _date,
              VoidCallback: (date) => date!.isEmpty
                  ? " date  Can’t be Empty"
                  : null,
            ),
          ],
        ),
      ),
    ),
    ),
    );
  },
);
  }
}
