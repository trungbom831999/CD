// import 'package:facebook_app/data/model/friend.dart';
// import 'package:facebook_app/viewmodel/chat_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:facebook_app/models/list_friend_model.dart';
// import 'package:facebook_app/view/chat/chat_detail/chat_detailv2.dart';
//
// class ConversationItem extends StatefulWidget {
//   final ChatProvide provide;
//   final Friend friend;
//   ConversationItem(this.provide, this.friend);
//
//   _ConversationItemState createState() => _ConversationItemState(this.provide, this.friend);
// }
//
// class _ConversationItemState extends State<ConversationItem> {
//   final ChatProvide provide;
//   final Friend friend;
//   _ConversationItemState(this.provide, this.friend);
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ChatDetail(friend),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 12.0),
//         child: Slidable(
//           actionPane: SlidableDrawerActionPane(),
//           actionExtentRatio: 0.15,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.0),
//             child: Row(
//               children: <Widget>[
//                 _buildConversationImage(),
//                 _buildTitleAndLatestMessage(),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             Padding(
//               padding: EdgeInsets.only(left: 16.0),
//               child: SlideAction(
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.camera_alt,
//                   color: Colors.white,
//                   size: 20.0,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//               child: SlideAction(
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.phone,
//                   color: Colors.black,
//                   size: 20.0,
//                 ),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.only(right: 16.0),
//               child: SlideAction(
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.videocam,
//                   color: Colors.black,
//                   size: 20.0,
//                 ),
//               ),
//             ),
//           ],
//           secondaryActions: <Widget>[
//             Padding(
//               padding: EdgeInsets.only(left: 16.0),
//               child: SlideAction(
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.menu,
//                   color: Colors.black,
//                   size: 20.0,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: 8.0, right: 8.0),
//               child: SlideAction(
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.notifications,
//                   color: Colors.black,
//                   size: 20.0,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(right: 16.0),
//               child: SlideAction(
//                 decoration: BoxDecoration(
//                   color: Colors.red,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.restore_from_trash,
//                   color: Colors.white,
//                   size: 20.0,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   _buildTitleAndLatestMessage() {
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.only(left: 12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             _buildConverastionTitle(),
//             SizedBox(height: 2),
//             Container(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   _buildLatestMessage(provide, friend),
//                   _buildTimeOfLatestMessage()
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   _buildConverastionTitle() {
//     return Text(
//       friend.userSecond.firstName + " " + friend.userSecond.lastName,
//       style: TextStyle(
//           fontSize: 14, color: Colors.grey.shade700, fontWeight: FontWeight.bold),
//     );
//   }
//
//   _buildLatestMessage(provide, friend) {
//     return Container(
//       width: 150.0,
//       child: Text(
//         getStringMess(provide, friend),
//         style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
//         overflow: TextOverflow.ellipsis,
//       ),
//     );
//   }
//
//   _buildTimeOfLatestMessage() {
//     return Text('1:21PM',
//         style: TextStyle(color: Colors.grey.shade700, fontSize: 11));
//   }
//
//   _buildConversationImage() {
//     return Container(
//       height: 50,
//       width: 50,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(30.0),
//         image: DecorationImage(
//           image: NetworkImage(friend.userSecond.avatar),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }
//
// String getStringMess(ChatProvide provide,Friend friend) {
//   provide.getChatDetail(friend: friend.userSecond);
//   return provide.messages[provide.messages.length-1].message;
// }
