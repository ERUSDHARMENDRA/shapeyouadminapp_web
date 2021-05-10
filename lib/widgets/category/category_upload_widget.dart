import 'dart:html';
import 'package:ars_dialog/ars_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shapeyouadmin_web/services/firebase_services.dart';
import 'package:firebase/firebase.dart' as fb;

class CategoryCreateWidget extends StatefulWidget {
  const CategoryCreateWidget({Key key}) : super(key: key);

  @override
  _CategoryCreateWidgetState createState() => _CategoryCreateWidgetState();
}

class _CategoryCreateWidgetState extends State<CategoryCreateWidget> {
  bool _visible = false;
  bool _imageSelected = true;
  FirebaseServices _services=FirebaseServices();
  String _url;
  String _path;
  var _fileNameTextController = TextEditingController();
  var _categoryNameTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Target Inbound"),
        title: Text("HummingBird approaching.ETA 1 minutes, May not be here in two minutes")
    );

    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Row(
        children: [
          Row(
            children: [
              Visibility(
                visible: _visible,
                child: Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 30,
                        child: TextField(
                          controller: _categoryNameTextController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black, width: 1),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'No Category Name Given',
                            border: OutlineInputBorder(),
                            contentPadding:
                            EdgeInsets.only(left: 20),
                          ),
                        ),
                      ),
                      AbsorbPointer(
                        absorbing: true,
                        child: SizedBox(
                            width: 200,
                            height: 30,
                            child: TextField(
                              controller: _fileNameTextController,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Upload Image',
                                border: OutlineInputBorder(),
                                contentPadding:
                                EdgeInsets.only(left: 20),
                              ),
                            ),),
                      ),
                    ],
                  ),
                ),
              ),

              FlatButton(
                onPressed: () {
                  uploadStorage();
                },
                color: Colors.black54,
                child: Text(
                  'No image Selected',
                  style: TextStyle(color: Colors.white),
                ),
              ),

              SizedBox(
                width: 10,
              ),

              AbsorbPointer(
                absorbing: _imageSelected,
                child: FlatButton(
                  onPressed: () {
                    if(_categoryNameTextController.text.isEmpty){
                      _services.showMyDialog(
                        context: context,
                        title: 'Add New Category',
                        message: 'New Category Name not given',
                      );
                    }
                    progressDialog.show();
                    _services.uploadCategoryImageToDb(_url,_categoryNameTextController.text).then((downloadUrl){
                      if(downloadUrl!=null){
                        progressDialog.dismiss();
                        _services.showMyDialog(
                          title: 'New Category Image',
                          message: 'Saved New Category Successfully',
                          context: context,
                        );
                      }
                    });

                    _categoryNameTextController.clear();
                    _fileNameTextController.clear();

                    },
                  color: _imageSelected?Colors.black12:Colors.black54,
                  child: Text(
                    'Save New Category',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              // ignore: deprecated_member_use
              Visibility(
                visible: _visible?false:true,
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _visible = true;
                    });
                  },

                  color: Colors.black54,
                  child: Text(
                    'Add New Category',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void uploadImage({@required Function(File file) onSelected}) {
    InputElement uploadInput = FileUploadInputElement()
      ..accept = 'images/*'; //it will upload only image
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file = uploadInput.files.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
      });
    });
  }

  void uploadStorage() {
    //upload selected image to firestore
    final dateTime = DateTime.now();
    final path = 'CategoryImage/$dateTime';
    uploadImage(onSelected: (file) {
      if (file != null) {
        setState(() {
          _fileNameTextController.text = file.name;
          _imageSelected = false;
          _url = path;
        });
        fb
            .storage()
            .refFromURL('gs://shapeyou-42b8c.appspot.com/')
            .child(path)
            .put(file);
      }
    });
  }
}
