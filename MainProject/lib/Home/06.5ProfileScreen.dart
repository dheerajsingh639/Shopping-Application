import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:googlelogin/Registration%20page/04.1Loginpage.dart';

import '06.1Home.dart';


class ProfileScreen extends StatelessWidget {
  
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ProfileCard(
            name: "Sepide",
            email: "theflutterway@gmail.com",
            imageSrc: "https://i.imgur.com/IXnwbLk.png",
            press: () {
              // Navigator.pushNamed(context, userInfoScreenRoute);-------------->
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Account",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: 16.0 / 2),
          ProfileMenuListTile(
            text: "Orders",
            svgSrc: "./images/Order.svg",
            press: () {
              // Navigator.pushNamed(context, ordersScreenRoute);-------------->
            },
          ),
          ProfileMenuListTile(
            text: "Returns",
            svgSrc: "./images/Return.svg",
            press: () {},
          ),
          ProfileMenuListTile(
            text: "Wishlist",
            svgSrc: "./images/Wishlist.svg",
            press: () {},
          ),
          ProfileMenuListTile(
            text: "Addresses",
            svgSrc: "./images/Address.svg",
            press: () {
              // Navigator.pushNamed(context, addressesScreenRoute);----------->
            },
          ),
          ProfileMenuListTile(
            text: "Payment",
            svgSrc: "./images/card.svg",
            press: () {
              // Navigator.pushNamed(context, emptyPaymentScreenRoute);-------->
            },
          ),
          ProfileMenuListTile(
            text: "Wallet",
            svgSrc: "./images/Wallet.svg",
            press: () {
              // Navigator.pushNamed(context, walletScreenRoute);-------------->
            },
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 16.0 / 2),
            child: Text(
              "Personalization",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          DividerListTileWithTrilingText(
            svgSrc: "./images/Notification.svg",
            title: "Notification",
            trilingText: "Off",
            press: () {
              // Navigator.pushNamed(context, enableNotificationScreenRoute);----------->
            },
          ),
          ProfileMenuListTile(
            text: "Preferences",
            svgSrc: "./images/Preferences.svg",
            press: () {
              // Navigator.pushNamed(context, preferencesScreenRoute);------------>
            },
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 16.0 / 2),
            child: Text(
              "Settings",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ProfileMenuListTile(
            text: "Language",
            svgSrc: "./images/Language.svg",
            press: () {
              // Navigator.pushNamed(context, selectLanguageScreenRoute);--------------->
            },
          ),
          ProfileMenuListTile(
            text: "Location",
            svgSrc: "./images/Location.svg",
            press: () {},
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 16.0 / 2),
            child: Text(
              "Help & Support",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          ProfileMenuListTile(
            text: "Get Help",
            svgSrc: "./images/Help.svg",
            press: () {
              // Navigator.pushNamed(context, getHelpScreenRoute);--------------->
            },
          ),
          ProfileMenuListTile(
            text: "FAQ",
            svgSrc: "./images/FAQ.svg",
            press: () {},
            isShowDivider: false,
          ),
          const SizedBox(height: 16.0),

          // Log Out
          ListTile(
            onTap: () {
              Get.to(Loginpage());
            },
            minLeadingWidth: 24,
            leading: SvgPicture.asset(
              "./images/Logout.svg",
              height: 24,
              width: 24,
              colorFilter: const ColorFilter.mode(
                Color(0xFFEA5B5B),
                BlendMode.srcIn,
              ),
            ),
            title: const Text(
              "Log Out",
              style: TextStyle(color: Color(0xFFEA5B5B), fontSize: 14, height: 1),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.name,
    required this.email,
    required this.imageSrc,
    this.proLableText = "Pro",
    this.isPro = false,
    this.press,
    this.isShowHi = true,
    this.isShowArrow = true,
  });


  final String name, email, imageSrc;
  final String proLableText;
  final bool isPro, isShowHi, isShowArrow;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: CircleAvatar(
        radius: 28,
        child: NetworkImageWithLoader(
          imageSrc,
          radius: 100,
        ),
      ),
      title: Row(
        children: [
          Text(
            isShowHi ? "$name" : name,
            style: const TextStyle(fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(width: 16.0 / 2),
          if (isPro)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0 / 2, vertical: 16.0 / 4),
              decoration: const BoxDecoration(
                color: Color(0xFF7B61FF),
                borderRadius:
                BorderRadius.all(Radius.circular(12.0)),
              ),
              child: Text(
                proLableText,
                style: const TextStyle(
                  fontFamily: "Grandis Extended",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: 0.7,
                  height: 1,
                ),
              ),
            ),
        ],
      ),
      subtitle: Text(email),
      trailing: isShowArrow
          ? SvgPicture.asset(
        "./images/miniRight.svg",
        // ignore: deprecated_member_use
        color: Theme.of(context).iconTheme.color!.withOpacity(0.4),
      )
          : null,
    );
  }
}

class ProfileMenuListTile extends StatelessWidget {
  const ProfileMenuListTile({
    super.key,
    required this.text,
    required this.svgSrc,
    required this.press,
    this.isShowDivider = true,
  });

  final String text, svgSrc;
  final VoidCallback press;
  final bool isShowDivider;

  @override
  Widget build(BuildContext context) {
    return DividerListTile(
      minLeadingWidth: 24,
      leading: SvgPicture.asset(
        svgSrc,
        height: 24,
        width: 24,
        colorFilter: ColorFilter.mode(
          Theme.of(context).iconTheme.color!,
          BlendMode.srcIn,
        ),
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 14, height: 1),
      ),
      press: press,
      isShowDivider: isShowDivider,
    );
  }
}

class DividerListTile extends StatelessWidget {
  const DividerListTile({
    super.key,
    this.isShowForwordArrow = true,
    required this.title,
    required this.press,
    this.leading,
    this.minLeadingWidth,
    this.isShowDivider = true,
  });
  final bool isShowForwordArrow, isShowDivider;
  final Widget title;
  final Widget? leading;
  final double? minLeadingWidth;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          minLeadingWidth: minLeadingWidth,
          leading: leading,
          onTap: press,
          title: title,
          trailing: isShowForwordArrow
              ? SvgPicture.asset(
            "./images/miniRight.svg",
            colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color!.withOpacity(0.4),
                BlendMode.srcIn),
          )
              : null,
        ),
        if (isShowDivider) const Divider(height: 1),
      ],
    );
  }
}

class DividerListTileWithTrilingText extends StatelessWidget {
  const DividerListTileWithTrilingText({
    super.key,
    required this.svgSrc,
    required this.title,
    required this.trilingText,
    required this.press,
    this.isShowArrow = true,
  });

  final String svgSrc, title, trilingText;
  final VoidCallback press;
  final bool isShowArrow;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: press,
          minLeadingWidth: 24,
          leading: SvgPicture.asset(
            svgSrc,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(
                Theme.of(context).iconTheme.color!, BlendMode.srcIn),
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 14, height: 1),
          ),
          trailing: SizedBox(
            width: 50,
            child: Row(
              children: [
                const Spacer(),
                Text(trilingText),
                SvgPicture.asset(
                  "./images/miniRight.svg",
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).iconTheme.color!.withOpacity(0.4),
                      BlendMode.srcIn),
                ),
              ],
            ),
          ),
        ),
        if (isShowArrow) const Divider(height: 1),
      ],
    );
  }
}

