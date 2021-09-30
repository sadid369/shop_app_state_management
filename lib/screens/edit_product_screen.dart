import 'package:flutter/material.dart';
import 'package:shop_app_state_management/provider/product.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_state_management/provider/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = 'edit-product-screen';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlControler = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _fromKey = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );
  var _intialValue = {
    'title': '',
    'description': '',
    'price': 0,
    'imageUrl': '',
  };
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  var _isInIt = true;
  @override
  void didChangeDependencies() {
    if (_isInIt) {
      final productID = ModalRoute.of(context)!.settings.arguments;
      if (productID != null) {
        _editedProduct = Provider.of<Products>(context, listen: false)
            .findById(productID.toString());
        _intialValue = {
          'title': _editedProduct.title.toString(),
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
        };
        _imageUrlControler.text = _editedProduct.imageUrl;
      }
    }
    _isInIt = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlControler.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((_imageUrlControler.text.startsWith('http') == false &&
              _imageUrlControler.text.startsWith('https') == false) ||
          (_imageUrlControler.text.startsWith('.png') == false &&
              _imageUrlControler.text.startsWith('.jpg') == false &&
              _imageUrlControler.text.startsWith('.jpeg') == false)) {
        return;
      }
      setState(() {});
    }
  }

  void _saveFrom() {
    final isValid = _fromKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _fromKey.currentState?.save();
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: () {
              _saveFrom();
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _fromKey,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _intialValue['title'].toString(),
                  onSaved: (value) {
                    _editedProduct = Product(
                       isFavorite: _editedProduct.isFavorite,
                        id: _editedProduct.id,
                        title: value!,
                        description: _editedProduct.description,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                ),
                TextFormField(
                  initialValue: _intialValue['price'].toString(),
                  onSaved: (value) {
                    _editedProduct = Product(
                      isFavorite: _editedProduct.isFavorite,
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        price: double.parse(value!),
                        imageUrl: _editedProduct.imageUrl);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter a price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please Enter a Valid Number';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Please Enter A number greater then 0';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                ),
                TextFormField(
                  initialValue: _intialValue['description'].toString(),
                  onSaved: (value) {
                    
                    _editedProduct = Product(
                      isFavorite: _editedProduct.isFavorite,
                        id: _editedProduct.id,
                        title: _editedProduct.title,
                        description: value!,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl);
                  },
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description';
                    }
                    if (value.length < 10) {
                      return 'Sholud be at least 10 characters long';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  focusNode: _descriptionFocusNode,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      child: _imageUrlControler.text.isEmpty
                          ? Text('Enter a Image Url')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlControler.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                      margin: EdgeInsets.only(top: 8, right: 10),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter a Image URL';
                          }
                          if (value.startsWith('http') == false &&
                              value.startsWith('https') == false) {
                            return ' Please Enter a Valid URL';
                          }
                          if (value.endsWith('.png') == false &&
                              value.endsWith('.jpeg') == false &&
                              value.endsWith('.jpg') == false) {
                            return 'Please enter a vaild URL';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            isFavorite: _editedProduct.isFavorite,
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: value!);
                        },
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlControler,
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmitted: (_) {
                          _saveFrom();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
