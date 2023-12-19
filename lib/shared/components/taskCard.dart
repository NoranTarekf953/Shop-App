// ignore_for_file: file_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../cubit.dart';

Widget taskCard (Map task,context){
  return  Dismissible(
    key: Key(task['id'].toString()),
    onDismissed: (direction) {
      AppCubit.get(context).deleteDB(id: task['id']);
    },
    child: Padding(
        padding: const EdgeInsetsDirectional.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text('${task['time']}',
              style: const TextStyle(fontSize: 15),),
  
            ),
            const SizedBox(width: 20,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              
              Text('${task['title']}'),
              Text('${task['date']}',style: const TextStyle(color: Colors.grey),)
            ],),
  const Spacer(),
            IconButton(onPressed: (){
              AppCubit.get(context).updateDB(
                status: 'done',
                 id: task['id']);
  
                
            },
             icon: Icon(
              Icons.check_box,
              color: Colors.deepPurple[400],
             )),
             IconButton(onPressed: (){
              AppCubit.get(context).updateDB(
                status: 'archive',
                 id: task['id']);
             },
             icon: const Icon(
              Icons.archive_outlined,
              color: Colors.black54,
             )),
             IconButton(
              onPressed: (){
  
                AppCubit.get(context).deleteDB(id: task['id']);
              },
               icon: const Icon(Icons.delete,color: Colors.redAccent,))
          ],
        ),
      ),
  );
  
}

Widget buildTask({required List<Map> tasks }){
  return ConditionalBuilder(
          condition: tasks.isNotEmpty,
          builder: (context) => ListView.separated(
          itemBuilder: (context,index)=> taskCard(tasks[index],context),
           separatorBuilder: (context,index)=>Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey[300],
           ),
            itemCount: tasks.length),
         
          fallback:(context) => Center(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Icon(Icons.menu,color: Colors.grey[350],size: 70,),
              Padding(
            padding: const EdgeInsetsDirectional.only(start: 50,end: 50),
                child: Text('''No Tasks yet , please add tasks''',style: TextStyle(fontSize: 20,color: Colors.grey[350]),),
              )
            ],
                    ),
          ),
          );
   
}

void navigateTo (context,widget)=>Navigator.push(context,
 MaterialPageRoute(builder: (context)=>widget));

 void navigateAndFinish(context,widget) {
   Navigator.pushAndRemoveUntil(
  context,
    MaterialPageRoute(builder: (context)=>widget),
    (route) => false);
 }


 ToastFuture flutterToast({
  required String msg,
  BuildContext? context,
 required ToastState state ,
 })=> showToast(
                msg,
                context: context,
                duration: const Duration(seconds: 5),
                borderRadius: BorderRadius.circular(10),
                backgroundColor: changeToastColor(state),
                textStyle: const TextStyle(
                  color: Colors.white
                )
                
                


              );


enum ToastState  {success, error,warning}

Color changeToastColor (ToastState state){
  late Color color;
  switch (state) {
    case ToastState.success:
    color = Colors.green;
      break;
      case ToastState.error:
    color = Colors.red;
      break;
      case ToastState.warning:
    color = Colors.amber;
      break;
    
  }
  return color;
}