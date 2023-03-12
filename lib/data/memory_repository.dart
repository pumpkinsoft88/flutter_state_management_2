import 'package:flutter/material.dart';

import 'models/recipe.dart';
import 'models/ingredient.dart';
import 'repository.dart';

class MemoryRepository extends Repository with ChangeNotifier {
  final List<Recipe> _currentRecipes = <Recipe>[];
  final List<Ingredient> _currentIngredients = <Ingredient>[];

  @override
  void close() {}

  @override
  Future create() {
    throw UnimplementedError();
  }

  @override
  void deleteIngredient(Ingredient ingredient) {
    _currentIngredients.remove(ingredient);
    notifyListeners();
  }

  @override
  void deleteIngredients(List<Ingredient> ingredients) {
    _currentIngredients
        .removeWhere((ingredient) => ingredients.contains(ingredient));
    notifyListeners();
  }

  @override
  void deleteRecipe(Recipe recipe) {
    _currentRecipes.remove(recipe);
    if (recipe.id != null) {
      deleteRecipeIngredients(recipe.id!);
    } else {
      notifyListeners();
    }
  }

  @override
  void deleteRecipeIngredients(int recipeId) {
    _currentIngredients
        .removeWhere((ingredient) => ingredient.recipeId == recipeId);
    notifyListeners();
  }

  @override
  List<Ingredient> findAllIngredients() {
    return _currentIngredients;
  }

  @override
  List<Recipe> findAllRecipes() {
    return _currentRecipes;
  }

  @override
  Recipe findRecipeById(int id) {
    return _currentRecipes.firstWhere((recipe) => recipe.id == id);
  }

  @override
  List<Ingredient> findRecipeIngredients(int recipeId) {
    return _currentIngredients
        .where((ingredient) => ingredient.recipeId == recipeId)
        .toList();
  }

  @override
  List<int> insertIngredients(List<Ingredient> ingredients) {
    if (ingredients.isNotEmpty) {
      _currentIngredients.addAll(ingredients);
      notifyListeners();
    }
    return <int>[];
  }

  @override
  int insertRecipe(Recipe recipe) {
    _currentRecipes.add(recipe);
    if (recipe.ingredients != null) {
      _currentIngredients.addAll(recipe.ingredients!);
    }
    notifyListeners();
    return 0;
  }
}
