
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:glade/constant.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CustomUtils {


  static Future<ProgressDialog> showProgressDialog(
      BuildContext context, String title) async {
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(
        progressWidget: Container(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: SpinKitRing(
                size: 50,
                lineWidth: 4,
                color:kprimary,
//                itemBuilder: (_, __) {
//                  return SizedBox(
//                    height: 3,
//                    width: 3,
//                    child: DecoratedBox(
//                      decoration: BoxDecoration(
//                        shape: BoxShape.circle,
//                        color: Colors.amber[700],
//                      ),
//                    ),
//                  );
//                },
              ),
            )),
        message: title,
        messageTextStyle: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 15,
            fontWeight: FontWeight.w400));
    await pr.show();
    return pr;
  }
}