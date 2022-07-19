import 'package:flutter/cupertino.dart';

class HistoryImage extends StatelessWidget {
  var HistoryImage1;

   HistoryImage({required this.HistoryImage1}) ;

  @override
  Widget build(BuildContext context) {
   return SafeArea(
     child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            HistoryImage1,
            fit: BoxFit.fill,
          ),
        ),
      ),
   );
  }
}
