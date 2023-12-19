// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, non_constant_identifier_names

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/taskCard.dart';


// ignore: non_constant_identifier_names
Widget Build_article_item(article, context) {
  return  InkWell(
    onTap: (){
      /*navigateTo(context, 
      //WebView(url: article['url'])
      );*/
    },
    child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 5, end: 5),
              child: Container(
                margin: const EdgeInsetsDirectional.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                padding: const EdgeInsetsDirectional.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            '${article['urlToImage']}'))),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 100,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text('${article['title']}',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                      ),
                                      Text(
                                        '${article['publishedAt']}',
                                        style:
                                            Theme.of(context).textTheme.bodyMedium,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ]),
              ),
                        
                  
            ),
  )
    ;
}


Widget myDivider()=>Padding(
                      padding: const EdgeInsetsDirectional.all(10),
                      child: Container(
                        height: 1,
                        color: Colors.grey[400],
                      ),
                    );


Widget article_builder(list,context,{isSearch = false}){
  ScrollController controller = ScrollController();
  return ConditionalBuilder(
    condition: list.length>0,
     builder: (context)=> NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo){
        return true;
      },
       child: ListView.separated(
        scrollDirection: Axis.vertical,
        controller: controller,
       
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context,index)=>Build_article_item(list[index], context),
         separatorBuilder: (context,index)=>myDivider(),
          itemCount: list.length),
     ),
      fallback: (context) => isSearch ? Container() :const Center(
            child: CircularProgressIndicator(),
          ));
}