import 'dart:math';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:liquidparserpack/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late LiquidController liquidController;
  late UpdateType updateType;
  int page = 0;
  TextEditingController _controller = TextEditingController();
  List<Item> data = [
    Item(Colors.amber, 'assets/google.png', 'Google Search', 'https', 'google.com'),
    Item(Colors.white, 'assets/mail.png', 'E-Mail', "mailto", "talha.wahid15@gmail.com"),
    Item(Color(0xff00ff00), 'assets/call.png', 'Call', "tel", "03111222333"),
    Item(Color(0xff0047ab), 'assets/message.png', 'Message', "sms", "03111222333"),
  ];

  

  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("LiquidSwipe & UrlLauncher-Flutter", style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal)),
      ),
      body: Stack(
        children: <Widget>[
          Expanded(
            child: LiquidSwipe.builder(
              itemCount:  data.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: data[index].color,
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.22),
                        ),
                    GestureDetector(
                      onTap: () => Url().url(data[index].scheme, _controller.text),
                      child: Image.asset(data[index].image,
                      height: 200,
                      fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                          padding: EdgeInsets.all(20.0),
                        ),
                    SizedBox(height: 20,),
                    Center(child: Text(data[index].text, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: index > 1 ? Colors.white : Colors.black),)),
                    SizedBox(height: 20,),
                    Center(child: Text("Click At Icon", style: TextStyle(fontSize: 16, color: index > 1 ? Colors.white : Colors.black)),)
                  ],),
                );
              },
              positionSlideIcon: 0.8,
              slideIconWidget: Icon(Icons.arrow_back_ios),
              onPageChangeCallback: pageChangeCallback,
              waveType: WaveType.liquidReveal,
              liquidController: liquidController,
              fullTransitionValue: 880,
              enableSideReveal: true,
              enableLoop: true,
              ignoreUserGestureWhileAnimating: true, 
              ),
          ),
      
      Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(data.length, _buildDot),
          ),
        ],),
        ),
      
        Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextButton(
                  onPressed: () {
                    liquidController.animateToPage(
                        page: data.length - 1, duration: 700);
                  },
                  child: Text("Skip to End", style: TextStyle(color: Colors.black),),
                  
                ),
              ),
            ),
          
          Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextButton(
                  onPressed: () {
                    liquidController.jumpToPage(
                        page: liquidController.currentPage + 1 > data.length - 1
                            ? 0
                            : liquidController.currentPage + 1);
                  },
                  child: Text("Next", style: TextStyle(color: Colors.black)),
                  
                ),
              ),
            )
        
      
      ]
      ),
    );
  }

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page ?? 0) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return new Container(
      width: 25.0,
      child: new Center(
        child: new Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: new Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

pageChangeCallback(int lpage) {
    setState(() {
      page = lpage;
    });
  }



}

class Item{

  late Color color;
  late String image;
  late String text;
  late String scheme;
  late String path;

  Item(this.color, this.image, this.text, this.scheme ,this.path);
 
}