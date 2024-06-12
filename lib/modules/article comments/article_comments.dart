import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled5/SharedPreferences/SharedPreferencesHelper.dart';
import 'article_comments_controller.dart';
import 'article_comments_service.dart';
import 'package:get/get.dart';

class CommentView extends StatefulWidget {
  final String apiUrl;
  final int id;
  const CommentView({super.key, required this.apiUrl, required this.id});
  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  final CommentController commentController = Get.put(CommentController());

  final TextEditingController commentControllerText = TextEditingController();

  @override
  void initState() {
    commentController.getComments(apiUrl: widget.apiUrl, id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[50],
        title: Row(
          children: [
            SizedBox(
              width: screenwidth * 0.001,
            ),
            /*   IconButton(onPressed:(){
              Get.back();
            },
              icon: Icon(Icons.arrow_back),
            ),*/
            Text(
              'Comments',
              style: TextStyle(color: Colors.blueGrey),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                if (commentController.commentState.value ==
                    CommentState.loading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (commentController.commentState.value ==
                    CommentState.error) {
                  return SizedBox();
                }
                return ListView.builder(
                  itemCount: commentController.commentModel!.comment!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      focusColor: Colors.blue,
                      //hoverColor,
                      //splashColor,
                      leading: CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(commentController
                                .commentModel!.comment![index].user!.image ??
                            ""),
                      ),
                      title: Text(
                        commentController
                                .commentModel!.comment![index].user!.name ??
                            "name" +
                                '   ' +
                                '${commentController.commentModel!.comment![index].date}',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  commentController.commentModel!
                                      .comment![index].commentText!,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(color: Colors.black38),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              if (AppSharedPreferences.getId ==
                                  commentController.commentModel!
                                      .comment![index].user!.id) ...[
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    size: 15,
                                  ),
                                  onPressed: () {

                                       
                                  showDialog(
                                    context: context,
                                  
                                    builder: (context) {
                                      TextEditingController editController =
                                          TextEditingController(
                                            text:  commentController.commentModel!
                                      .comment![index].commentText!
                                           );
                                      return AlertDialog(
                                        title: Text('Edit Comment'),
                                        content: TextField(
                                          controller: editController,
                                          decoration: InputDecoration(
                                              hintText: 'Edit your comment'),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text('Cancel'),
                                            onPressed: () => Get.back(),
                                          ),
                                          TextButton(
                                            child: Text('Save'),
                                            onPressed: () {

                                                 commentController.updateComment(
                                        commedntId: commentController
                                            .commentModel!.comment![index].id!,
                                        apiUrl: widget.apiUrl,
                                        id: widget.id,
                                        commentText:
                                            editController.text);
                                             
                                            
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    size: 15,
                                  ),
                                  onPressed: () {
                                    commentController.deleteComment(
                                        commedntId: commentController
                                            .commentModel!.comment![index].id!,
                                        apiUrl: widget.apiUrl,
                                        id: widget.id,
                                        commentText:
                                            commentControllerText.text);
                                  },
                                ),
                              ],
                              IconButton(
                                icon: Icon(
                                  Icons.thumb_up,
                                  size: 15,
                                ),
                                onPressed: () {
                                  // commentController.likeComment(comment.id);
                                },
                              ),
                              // Text('${comment.likes}'),
                            ],
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
                              commentController.addComment(
                                  apiUrl: widget.apiUrl,
                                  id: widget.id,
                                  commentText: commentControllerText.text);
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