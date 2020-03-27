import 'dart:math';

import 'package:flutter/material.dart';

 class Onboardingpage extends StatefulWidget {
  
  Onboardingpage({Key key}) : super(key:key);
  _OnboardingpageState createState() => _OnboardingpageState();
}

class _OnboardingpageState extends State<Onboardingpage> {
  
  
  final int totalpages = 3;
  final PageController pageController = PageController(initialPage:0);
  int currentpage = 0;


  Widget buildpageindicator(bool iscurrentpage)
  {
    return AnimatedContainer (
      duration:Duration(milliseconds : 375)
      ,margin: EdgeInsets.symmetric(horizontal:2),
      height: iscurrentpage ? 10 : 6,
      width: iscurrentpage ? 10 : 6,
      decoration: BoxDecoration(color: iscurrentpage ? Colors.blueGrey : Colors.blueGrey[300],
       borderRadius: BorderRadius.circular(12)),
      );
    
  }

@override
  Widget build(BuildContext context) {

    return Scaffold
    (
      body: Container(
      height: double.infinity,
      child:
       PageView(
          controller: PageController(),
          onPageChanged: (int page){
              currentpage=page;
              setState(() {});
          },

         children:<Widget>[
          _buildpage(image:'assets/selfie.png',
                  title:'Easily create and manage event',
                  body: 'Think about getting things done ... you have come to the right place.'),
                 
          _buildpage(image:'assets/moshing.png',
                  title:'Passionate about something ??',
                  body: 'Passion is the only prerequesite here.'),
        
          _buildpage(image:'assets/levitate.gif',
                  title:'Wrapping up',
                  body: 'Get ready for some serious responsibilities !!!'),
         ])
    ),

    bottomSheet: currentpage != 2 ?
     Container(
       padding : EdgeInsets.symmetric(vertical:17),
       child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:<Widget>
      [
        FlatButton(onPressed: (){
          pageController.animateToPage(2, duration: Duration(milliseconds:400), curve: Curves.linear);

        }, 
        child: Text('SKIP' , style: TextStyle(color: Color(0xFF0074E4)),))
        ,
              Container(
                    child: Row(children: [
                      for (int i = 0; i < totalpages; i++) i == currentpage ? buildpageindicator(true) : buildpageindicator(false)
                    ]),
                  ), 
        
        FlatButton(onPressed: (){
          pageController.animateToPage(currentpage+1, duration: Duration(milliseconds:400), curve: Curves.linear);
        }, 
        child: Text('NEXT' , style: TextStyle(color: Color(0xFF0074E4)),))
      ]),)
      :Container(
        child: InkWell(
          onTap: ()=>print('get started now'),
          child:
          Container(
            height: 60,
            color: Colors.redAccent,
            alignment: Alignment.center,
            child: 
              Text('LETS GET STARTED',
              style:TextStyle(color:Colors.white ,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,),
          )
        ),
      ),
    );
  }
Widget _buildpage({String image,String title,String body}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal:24),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget>
            [Image.asset(image),
            SizedBox(height: 40),
            Text(title , style: TextStyle(fontSize:20,fontWeight : FontWeight.bold),textAlign: TextAlign.center,),
            SizedBox(height:10),
            Text(body,style: TextStyle(fontSize:15,),textAlign: TextAlign.center,)]
      ),
  );
}
}