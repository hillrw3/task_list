angular.module('taskApp').controller('newListCtrl', ['$scope', '$modalInstance', function($scope, $modalInstance) {

  $scope.createNewList = function createNewList() {
    var list = {name: $scope.listName};
    $scope.lists.push(list);
    $scope.listName = '';
    $modalInstance.dismiss();
  };

  $scope.cancel = function () {
    $modalInstance.dismiss('cancel');
  };
}]);