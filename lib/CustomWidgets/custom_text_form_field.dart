import 'package:flutter/material.dart';

class CustomTFD extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback ;
  final TextInputAction action;
  final TextInputType type;
  final Function(String)? func;
  final dynamic ?onTap;


  final  String label;
  const CustomTFD({super.key ,required this.label,required this.controller, this.VoidCallback, required this.type, required this.action,  this.func, this.onTap });

  @override
  State<CustomTFD> createState() => _CustomTFDState();
}

class _CustomTFDState extends State<CustomTFD> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding:const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width/1,
      height:MediaQuery.of(context).size.height/12,
      child: TextFormField(
        onTap:widget.onTap ,
        onFieldSubmitted: widget.func,
        textInputAction:widget.action ,
        keyboardType: widget.type,
        validator: widget.VoidCallback,
        controller:widget.controller ,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.black),
          labelText: widget.label,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:  BorderSide(
              color: Colors.red.shade900,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          errorStyle: const TextStyle(fontWeight: FontWeight.bold,height: .1),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color:Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
