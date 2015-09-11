angular.module('taskApp').controller('emailModalCtrl', ['$scope', '$modalInstance', 'List', 'list', function ($scope, $modalInstance, List, list) {
  $scope.send = function send() {
    List.email({id: list.id, recipients: $scope.recipients()});

    $modalInstance.dismiss();
    $scope.recipientString = undefined;
  };

  $scope.cancel = function () {
    $modalInstance.dismiss('cancel');
  };

  $scope.recipients = function recipients() {
    return $scope.recipientString.split(', ')
  }
}]);