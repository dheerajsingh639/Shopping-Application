import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '06.1Home.dart';
import '06.2DiscoverScreen.dart';
import '06.4CartScreen.dart';
import '06.5ProfileScreen.dart';
import '../Screen/Notigication.dart';

const Duration defaultDuration = Duration(milliseconds: 300);
const Color primaryColor = Color(0xFF7B61FF);


//This is our 4 Tabs routes ----> 

class Gemstore extends StatefulWidget {

   const Gemstore({
    super.key,
  });

  @override
  State<Gemstore> createState() => _GemstoreState();
}

class _GemstoreState extends State<Gemstore> {

  
  
  final List<Widget> _pages = [
    HomeScreen(),
    DiscoverScreen(),
    CartScreen(),
    ProfileScreen(),
    
  ];
  int _currentIndex = 0;
    
  @override
  Widget build(BuildContext context) {
    SvgPicture svgIcon(String src, {Color? color}) {
      return SvgPicture.asset(
        src,
        height: 24,
        colorFilter: ColorFilter.mode(
            color ?? Theme.of(context).iconTheme.color!.withOpacity(
             Theme.of(context).brightness == Brightness.dark ? 0.3 : 1),
              BlendMode.srcIn),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: const SizedBox(),
        leadingWidth: 0,
        centerTitle: false,
        title: SvgPicture.asset(
          "./images/Shoplon.svg",
          colorFilter: ColorFilter.mode(
              Theme.of(context).iconTheme.color!, BlendMode.srcIn),
          height: 20,
          width: 100,
        ),


        actions: [
          IconButton(
            onPressed: () {  },
            icon: SvgPicture.asset(
              "./images/Search.svg",
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).textTheme.bodyLarge!.color!,
                  BlendMode.srcIn),
            ),
          ),
          IconButton(
            onPressed: () {
              Get.to(NotificationsScreen());
            },
            icon: SvgPicture.asset(
              "./images/Notification.svg",
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).textTheme.bodyLarge!.color!,
                  BlendMode.srcIn),
            ),
          ),
        ],
      ),


     // Tab bar sliding logic
      body: PageTransitionSwitcher(
        duration: defaultDuration,
        transitionBuilder: (child, animation, secondAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondAnimation,
            child: child,
          );
        },
        child: _pages[_currentIndex],
      ),


      
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: defaultPadding / 2),
        color: Theme.of(context).brightness == Brightness.light? Colors.white : const Color(0xFF101015),


        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index != _currentIndex) {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.white : const Color(0xFF101015),
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.transparent,
          items: [

            
      //This is our bottom nav bar icons and moveablity code
            BottomNavigationBarItem(
              icon: svgIcon("./images/Shop.svg"),
              activeIcon: svgIcon("./images/Shop.svg", color: primaryColor),
              label: "Shop",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("./images/Category.svg"),
              activeIcon:
              svgIcon("./images/Category.svg", color: primaryColor),
              label: "Discover",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("./images/Bag.svg"),
              activeIcon: svgIcon("./images/Bag.svg", color: primaryColor),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("./images/Profile.svg"),
              activeIcon:
              svgIcon("./images/Profile.svg", color: primaryColor),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}



