import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/providers/products.dart';
import 'package:provider/provider.dart';

class editProductScreen extends StatefulWidget {
  const editProductScreen({super.key});
  static final routeName = '/edit-product';
  @override
  State<editProductScreen> createState() => _editProductScreenState();
}

class _editProductScreenState extends State<editProductScreen> {
  final _priceFouseNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: '', title: '', description: '', price: 0, imageUrl: ' ');

  var _isInit = true;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments as String?;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findbyId(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  final _imageUrlController = TextEditingController();

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if (!isValid!) return;
    _form.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id != "") {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct)
          .catchError((error) {
        return showDialog<Null>(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Error'),
                  content: Text(error.toString()),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'))
                  ],
                ));
      }).then((_) => Navigator.of(context).pop());
      setState(() {
        _isLoading = false;
      });
    }
    // print(_editedProduct.title);
    // print(_editedProduct.description);
    // print(_editedProduct.price);
    // print(_editedProduct.imageUrl);
    //print(_editedProduct.id);

    //Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Product'),
          actions: [IconButton(onPressed: _saveForm, icon: Icon(Icons.save))],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                    key: _form,
                    child: ListView(
                      children: [
                        TextFormField(
                          initialValue: _initValues['title'],
                          decoration: InputDecoration(labelText: 'Title'),
                          textInputAction: TextInputAction.next,
                          onSaved: (newValue) {
                            _editedProduct = Product(
                                isFavorite: _editedProduct.isFavorite,
                                id: _editedProduct.id,
                                title: newValue as String,
                                description: _editedProduct.description,
                                price: _editedProduct.price,
                                imageUrl: _editedProduct.imageUrl);
                          },
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Please provide a title ';
                            return null;
                          },
                        ),
                        TextFormField(
                          initialValue: _initValues['price'],
                          decoration: InputDecoration(labelText: 'Price'),
                          textInputAction: TextInputAction.next,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          focusNode: _priceFouseNode,
                          onSaved: (newValue) {
                            _editedProduct = Product(
                                isFavorite: _editedProduct.isFavorite,
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                price: double.parse(newValue as String),
                                imageUrl: _editedProduct.imageUrl);
                          },
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Please provide a value ';
                            return null;
                          },
                        ),
                        TextFormField(
                          initialValue: _initValues['description'],
                          decoration: InputDecoration(labelText: 'Description'),
                          maxLines: 3,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.multiline,
                          onSaved: (newValue) {
                            _editedProduct = Product(
                                isFavorite: _editedProduct.isFavorite,
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: newValue as String,
                                price: _editedProduct.price,
                                imageUrl: _editedProduct.imageUrl);
                          },
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Please provide a title ';
                            return null;
                          },
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.only(
                                top: 8,
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              )),
                              child: _imageUrlController.text.isEmpty
                                  ? Text('Enter a URL')
                                  : FittedBox(
                                      child: Image.network(
                                          _imageUrlController.text),
                                    ),
                            ),
                            Expanded(
                              child: TextFormField(
                                //initialValue: _initValues['imageUrl'],
                                decoration:
                                    InputDecoration(labelText: 'Image URL'),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                controller: _imageUrlController,
                                onEditingComplete: () {
                                  setState(() {});
                                },
                                onFieldSubmitted: (_) => _saveForm(),
                                onSaved: (newValue) {
                                  _editedProduct = Product(
                                      isFavorite: _editedProduct.isFavorite,
                                      id: _editedProduct.id,
                                      title: _editedProduct.title,
                                      description: _editedProduct.description,
                                      price: _editedProduct.price,
                                      imageUrl: newValue as String);
                                },
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return 'Please provide a title ';
                                  return null;
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ));
  }
}
