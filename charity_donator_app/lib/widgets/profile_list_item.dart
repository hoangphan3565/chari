import 'package:charity_donator_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final Function press;

  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.press,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSpacingUnit.toDouble() * 5.5,
      margin: EdgeInsets.symmetric(
        horizontal: kSpacingUnit.toDouble() * 4,
      ).copyWith(
        bottom: kSpacingUnit.toDouble() * 2,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: kSpacingUnit.toDouble() * 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kSpacingUnit.toDouble() * 3),
        color: kPrimaryLightColor,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            this.icon,
            size: kSpacingUnit.toDouble() * 2.5,
          ),
          SizedBox(width: kSpacingUnit.toDouble() * 1.5),
          FlatButton(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            onPressed: press,
            child: Text(
              this.text,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Spacer(),
          if (this.hasNavigation)
            Icon(
              LineAwesomeIcons.angle_right,
              size: kSpacingUnit.toDouble() * 2.5,
            ),
        ],
      ),
    );
  }
}