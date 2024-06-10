import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'article_comments_controller.dart';
import 'article_comments_service.dart';
import 'package:get/get.dart';


class CommentView extends StatelessWidget {
  final CommentController commentController = Get.put(CommentController());
  final TextEditingController commentControllerText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[50],
        title: Row(
          children: [
            SizedBox(width:screenwidth*0.001 ,),
         /*   IconButton(onPressed:(){
              Get.back();
            },
              icon: Icon(Icons.arrow_back),
            ),*/
            Text('Comments',style: TextStyle(color: Colors.blueGrey),),
          ],
        ),
      ),
      body: Center(
        child: Container(
          width: screenwidth*0.95,
          height: screenheight,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
              return ListView.builder(
              itemCount: commentController.comments.length,
              itemBuilder: (context, index) {
              Comment comment = commentController.comments[index];
              return ListTile(
          focusColor:Colors.blue,
          //hoverColor,
          //splashColor,
          leading:CircleAvatar(
              radius: 15,
              backgroundImage: AssetImage('${commentController.image.value}'),
            ),
              title: Text('${commentController.name.value }'+ '   '+'${commentController.time.value}',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),
              subtitle:  Text(comment.content,style: TextStyle(color: Colors.black38),),
              trailing: Row(
          mainAxisSize: MainAxisSize.min,
              children: [
              IconButton(
              icon: Icon(Icons.edit,size: 15,),
              onPressed: () {
              // Code to edit comment
              showDialog(
              context: context,
              builder: (context) {
              TextEditingController editController = TextEditingController(text: comment.content);
              return AlertDialog(
              title: Text('Edit Comment'),
              content: TextField(
              controller: editController,
              decoration: InputDecoration(hintText: 'Edit your comment'),
              ),
              actions: [
              TextButton(
              child: Text('Cancel'),
              onPressed: () => Get.back(),
              ),
              TextButton(
              child: Text('Save'),
              onPressed: () {
              commentController.editComment(comment.id, editController.text);
              Get.back();
              },
              ),
              ],
              );
              },
              );
              },
              ),
              IconButton(
              icon: Icon(Icons.delete,size: 15,),
              onPressed: () {
              commentController.deleteComment(comment.id);
              },
              ),
              IconButton(
              icon: Icon(Icons.thumb_up,size: 15,),
              onPressed: () {
              commentController.likeComment(comment.id);
              },
              ),
          Text('${comment.likes}'),
              IconButton(
              icon: Icon(Icons.reply,size: 15,),
              onPressed: () {
              // Code to reply to comment
              showDialog(
              context: context,
              builder: (context) {
              TextEditingController replyController = TextEditingController();
              return AlertDialog(
              title: Text('Reply to Comment'),
              content: TextField(
              controller: replyController,
              decoration: InputDecoration(hintText: 'Enter your reply'),
              ),
              actions: [
              TextButton(
              child: Text('Cancel'),
              onPressed: () => Get.back(),
              ),
              TextButton(
              child: Text('Reply'),
              onPressed: () {
              commentController.addComment(replyController.text, parentId: comment.id);
              Get.back();
              },
              ),
              Obx(() {
              return ListView.builder(
              itemCount: commentController.comments.length,
              itemBuilder: (context, index) {
              commentController.getReplies(comment.id).map((reply) {
              return ListTile(
          focusColor:Colors.blue,
          leading:CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage('${commentController.image.value}'),
          ) ,
              title: Text('${commentController.name.value }'+ '   '+'${commentController.time.value}',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
              ),
              subtitle: Text(reply.content),
              trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
              IconButton(
              icon: Icon(Icons.edit,size: 15,),
              onPressed: () {
              // Code to edit reply
              showDialog(
              context: context,
              builder: (context) {
              TextEditingController editController = TextEditingController(text: reply.content);
              return AlertDialog(
              title: Text('Edit Reply'),
              content: TextField(
              controller: editController,
              decoration: InputDecoration(hintText: 'Edit your reply'),
              ),
              actions: [
              TextButton(
              child: Text('Cancel'),
              onPressed: () => Get.back(),
              ),
              TextButton(
              child: Text('Save'),
              onPressed: () {
              commentController.editComment(reply.id, editController.text);
              Get.back();
              },),],);},);},),
              IconButton(
              icon: Icon(Icons.delete,size: 15,),
              onPressed: () {
              commentController.deleteComment(reply.id);
              },
              ),
              IconButton(
              icon: Icon(Icons.thumb_up,size: 15,),
              onPressed: () {
              commentController.likeComment(reply.id);
              },
              ),
          Text('${comment.likes}'),
              ],
              ),
              );
              }).toList();
              },
              );
              }),
              ],
              );
              },
              );
              },
              ),
              ],
              ),
              );
              },
              );
              },
              ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: commentControllerText,
                        decoration: InputDecoration(
                          hintText: 'Add a Comment.... ',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          suffixIcon: IconButton(
                              icon: Icon(
                                Icons.send,
                              ),
                              onPressed: () {
                                if (commentControllerText.text.isNotEmpty) {
                                  commentController.addComment(commentControllerText.text);
                                  commentControllerText.clear();
                                }
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ],
              ),
        ),
      ),
    );
  }
}



/*
class ArticleComments extends StatefulWidget {
  const ArticleComments({super.key});

  @override
  State<ArticleComments> createState() => _ArticleCommentsState();
}

class _ArticleCommentsState extends State<ArticleComments> {
  final ArticleCommentsController _controller = Get.put(ArticleCommentsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 10,),
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.toNamed('/ArticlesDetails');
                  },
                ),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              child:SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 610,
                    child: Obx(
                          () => ListView.builder(
                        scrollDirection: Axis.vertical, // التمرير الشاقولي
                        itemCount: _controller.article_comments.length,
                        itemBuilder: (context, index) {
                          final Article_Comments article_comment = _controller.article_comments[index];
                          return GestureDetector(
                            onTap: () {
                              // يتم عرض تفاصيل الـ Card عند النقر عليه
                            },
                            child:
                            Container(
                              width: 300,
                              child:Column(
                          children:[
                                Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:[
                                  SizedBox(width: 40,),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundImage: AssetImage(
                                        article_comment.authorImageUrl),
                                  ),
                                      SizedBox(width: 20,),
                                      TextButton(
                                        onPressed: () {}, child: Text(
                                        article_comment.authorName,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                      ),
                                      SizedBox(width: 20,),

                                      Text(
                                        article_comment.time,
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                ],
                              ),
                            SizedBox(height: 10,),
                            Container(
                              width: 400,
                              color: Colors.black12,
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:[
                                  SizedBox(width: 30,),
                                  Text(
                                    article_comment.ArticleComment,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 6,),
                            Container(
                              width: 350,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(height: 15,),
                                  IconButton(onPressed:(){},
                                    icon:Icon(Icons.reply,
                                    color: Colors.blue,
                                      size: 17,
                                    ),
                                  ),
                                Text(
                                      'Reply',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 12,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            ],
                          ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ),
            SizedBox(height: 10,),
            Container(
              width: 400,
              height: 45,
              child: TextFormField(
                controller: _controller.add_Comment_Controller,
                decoration: InputDecoration(
                  hintText: 'Add a Comment.... ',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  suffixIcon: IconButton(
                      icon: Icon(
                        Icons.send,
                      ),
                      onPressed: () {

                      }),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
 */