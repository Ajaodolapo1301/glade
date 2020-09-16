
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:glade/constant.dart';
import 'package:progress_dialog/progress_dialog.dart';
enum DialogType { warning, error, success }
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



  static Future<void> showCustomDialog(DialogType type, BuildContext context,
      String message, String actionText, VoidCallback onClose,
      {String title, bool dismissible = false}) async {
    return showDialog(
        barrierDismissible: dismissible,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 0,
            contentPadding: EdgeInsets.all(0),
            backgroundColor: Colors.transparent,
            content: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Wrap(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TweenAnimationBuilder(
                          duration: Duration(milliseconds: 800),
                          curve: Curves.elasticInOut,
                          tween: Tween<double>(begin: 5, end: 25),
                          builder: (__, value, child) {
                            return Container(
                              child: Icon(
                                (type == DialogType.success)
                                    ? Icons.done :(type == DialogType.warning)?Icons.warning
                                    : Icons.error,
                                size: value,
                                color: (type == DialogType.success)
                                    ? Color(0XFF009845)
                                    :(type == DialogType.warning)?Colors.amber[700]: Colors.red,
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          title ??
                              ((type == DialogType.error)
                                  ? "Error!"
                                  : "Success!"),
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 15.0, top: 20),
                          child: Text(
                            message,
                            style: TextStyle(
                                fontSize: 14.0,color: Colors.grey[600]
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 25.0, bottom: 15.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                          padding: EdgeInsets.all(10),
                          onPressed: onClose,
                          color: (type == DialogType.success)
                              ? Color(0XFF009845)
                              :(type == DialogType.warning)?Colors.amber[700] : Colors.red,
                          child: Text(
                            actionText,
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }


}