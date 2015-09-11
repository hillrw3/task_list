angular.module('taskApp').controller('newListCtrl', ['$scope', '$modalInstance', 'List', function($scope, $modalInstance, List) {

  $scope.createNewList = function createNewList() {
    List.save({list_name: $scope.listName}).$promise.then(function(data) {
      $scope.lists.push(data);
      $scope.listName = '';
    });
    $modalInstance.dismiss();
  };

  $scope.cancel = function () {
    $modalInstance.dismiss('cancel');
  };
}]);