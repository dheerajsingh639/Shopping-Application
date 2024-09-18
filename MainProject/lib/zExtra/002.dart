import 'dart:async';
import 'package:flutter/material.dart';


class decoration extends StatefulWidget {
  const decoration({super.key});

  @override
  State<decoration> createState() => _decorationState();
}

class _decorationState extends State<decoration> {
  //Page Controller
  final PageController pageController = PageController();

  //Image List
  final List<String> Images = [
    "./images/Illustration-0.png",
    "./images/Illustration-1.png",
    "./images/Illustration-2.png",
    "./images/Illustration-3.png",
    "./images/Illustration-4.png",
  ];

  //Image Slider code Start
  int currentPage = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (currentPage < Images.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  //Image Slider code Start

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: Images.length,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  // Set the border radius here
                  child: Image.asset(
                    Images[index],
                    fit: BoxFit.cover,
                    height: 400,
                    width: 260,
                  ),
                ),
              );
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 690,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 290,
                      ),
                      Positioned(
                        bottom: 100,
                        child: TextButton.icon(
                            onPressed: () {
                            //  Get.off(LoginCheck());------------------->
                            },
                            label: Icon(
                              Icons.arrow_forward,
                              size: 40,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              //),
            ],
          ),
        ],
      ),
    );
  }
}
//Explain
