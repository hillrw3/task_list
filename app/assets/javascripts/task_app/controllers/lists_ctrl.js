angular.module('taskApp').controller('listsCtrl', ['$scope', '$modal', 'List', function($scope, $modal, List) {
  $scope.init = function init() {
    List.query().$promise.then(function(data) {
      $scope.lists = [data];
    });
  };

  $scope.openNewListModal = function openNewListModal() {
    $modal.open({
      template: JST['task_app/templates/new_list'](),
      controller: 'newListCtrl',
      scope: $scope
    })
  };
}]);