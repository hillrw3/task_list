describe('newListCtrl', function () {
  var $scope, $controller, $modalInstance, List, saveDeferred;

  beforeEach(module('taskApp'));

  beforeEach(inject(function($rootScope, _$controller_, _$modal_, $q) {
    $scope = $rootScope.$new();

    $modalInstance = _$modal_.open({
      template: JST['task_app/templates/new_list']()
    });

    List = {
      save: function() {
        saveDeferred = $q.defer();
        return { $promise: saveDeferred.promise }
      }
    };

    $controller = _$controller_;
    $controller('newListCtrl', {$scope: $scope, $modalInstance: $modalInstance, List: List})
  }));

  describe('#createNewList', function() {
    it('adds the new list to $scope.lists', function() {
      $scope.lists = [];

      $scope.createNewList();
      saveDeferred.resolve({name: 'new list'});
      $scope.$digest();

      expect($scope.lists).toEqual([{name: 'new list'}]);
    });

    it('resets $scope.listName', function() {
      $scope.listName = 'Groceries for Grandma';
      $scope.lists = [];

      $scope.createNewList();
      saveDeferred.resolve();
      $scope.$digest();

      expect($scope.listName).toEqual('');
    });

    it('closes the modal', function() {
      spyOn($modalInstance, 'dismiss');

      $scope.createNewList();

      expect($modalInstance.dismiss).toHaveBeenCalled();
    });
  });
});