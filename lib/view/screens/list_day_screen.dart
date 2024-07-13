import 'package:flutter/material.dart';
import 'package:schedule_app_flutter/view/widgets/day_card_item.dart';

class ListDayScreen extends StatefulWidget {
  const ListDayScreen({super.key});

  @override
  State<ListDayScreen> createState() => _ListDayScreenState();
}

class _ListDayScreenState extends State<ListDayScreen> {
  @override
  Widget build(BuildContext context) {
    return DayCardItem(onTap: (){}, day: 1);
  }
}
