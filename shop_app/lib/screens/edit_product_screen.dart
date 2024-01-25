import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  //FocusNode can be assigned to a text input widget
  final _descriptionFocusNode = FocusNode();
  //when working with focus nodes, we must dispose them when you leave this screen
  //or else they will stick around and lead to a memory leak
  final _imageUrlController = TextEditingController();
  //should dispose just like the focus node
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  //allows us to interact with the state behind the form widget
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  var _isInit = true;

  var _isLoading = false;

  var _initValues = {
    //default values to be displayed the respective text forms
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void didChangeDependencies() {
    //for lines of code to be in initState but can't be because those
    //lines of code require context
    //runs only once
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findByID(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          //'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') ||
              _imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        //checks for an incorrect url
        return;
      }

      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
  }

  //better syntax
  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      }
      // } finally {
      //   //this code should run regardless if there is an error or not
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  void _saveForm1() {
    final isValid = _form.currentState.validate();
    //provided by the Form class by Flutter
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct)
          .catchError((errorObject) {
        return showDialog(
          //we want to wait until user presses okay and without return, we would immediately go to .then()
          //we can return the result of showDialog (a Future), once showDialog is resolved by popping the showDialog
          //the then() method executes
          context: context,
          builder: (context) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        );
      }).then((_) {
        //will execute after catch error
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm)
        ],
      ),
      //creating a user input form
      //do not need a controller because Form will help us get the value
      //managing the behind the scenes stuff
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        //return null; means input is correct
                        //return 'This is wrong!'; is the error message
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(
                          labelText:
                              'Title'), //can configure error text style in decoration parameter
                      textInputAction: TextInputAction.next,
                      //TextInputAction.next shows that the soft keyboard action button will move to the next input
                      //instead of submitting the entire form
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                        //when this is submitted, automatically focus on the price field
                      },
                      //will fire when bottom right submit button is pressed
                      onSaved: (value) {
                        //value is the thing entered in the text form field
                        //must create a new product as the product's parameters are final
                        _editedProduct = Product(
                          title: value,
                          id: _editedProduct.id,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a price.';
                        }
                        if (double.tryParse(value) == null) {
                          //tryParse returns null if double.parse fails
                          return 'Please enter a valid number';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a number greater than 0';
                        }
                        return null;
                      },
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType:
                          TextInputType.number, //only should submit numbers
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                        //when this is submitted, automatically focus on the description field
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          id: _editedProduct.id,
                          description: _editedProduct.description,
                          price: double.parse(
                              value), //convert the string into a double
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a description';
                        }
                        if (value.length < 10) {
                          return 'Please enter a description of at least 10 characters';
                        }
                        return null;
                      },
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3, //how many lines should be rendered
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType
                          .multiline, //keyboard suited for multiline inputs, there will be an enter/return instead of submit
                      focusNode: _descriptionFocusNode,
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          id: _editedProduct.id,
                          description: value,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child:
                                      Image.network(_imageUrlController.text),
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an image url';
                              }
                              if (!(value.startsWith('http') ||
                                  value.startsWith('https'))) {
                                return 'Please enter a valid url';
                              }
                              if (!value.endsWith('png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return 'Please enter a valid image url';
                              }
                              return null;
                            },
                            //cannot have both an initialValue and a controller
                            //initialValue: _initValues['imageUrl'],
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (valueSubmitted) {
                              _saveForm();
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                title: _editedProduct.title,
                                id: _editedProduct.id,
                                description: _editedProduct.description,
                                price: _editedProduct.price,
                                imageUrl: value,
                                isFavorite: _editedProduct.isFavorite,
                              );
                              _updateImageUrl();
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
