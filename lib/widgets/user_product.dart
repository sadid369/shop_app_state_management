import 'package:flutter/material.dart';

class UserProduct extends StatelessWidget {
  final String title;
  final String imageUrl;
  const UserProduct({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl),), title: Text(title),trailing: Container(width: 100, child: Row(children: [
      IconButton(onPressed: (){}, icon: Icon(Icons.edit),),
      IconButton(onPressed: (){}, icon: Icon(Icons.delete, color: Theme.of(context).errorColor,)),
    ],),),);
  }
}
