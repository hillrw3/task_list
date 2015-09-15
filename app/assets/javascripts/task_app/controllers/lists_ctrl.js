angular.module('taskApp').controller('listsCtrl', ['$scope', '$modal', 'List', function($scope, $modal, List) {
  $scope.init = function init() {
    List.query().$promise.then(function(data) {
      $scope.lists = data;
    });
  };

  $scope.openNewListModal = function openNewListModal() {
    $modal.open({
      template: JST['task_app/templates/new_list'](),
      controller: 'newListCtrl',
      scope: $scope
    })
  };

  $scope.openOptionsDropdown = function openOptionsDropdown(e) {
    if (e) {
      e.preventDefault();
      e.stopPropagation();
    }
  };

  $scope.sendEmail = function sendEmail(list) {
    $modal.open({
      template: JST['task_app/templates/email_modal'](),
      controller: 'emailModalCtrl',
      resolve: {
        list: function() { return list }
      }
    })
  };

  $scope.deleteList = function deleteList(list) {
    List.delete({id: list.id});
    var index = $scope.lists.indexOf(list);
    $scope.lists.splice(index);
  };
}]);