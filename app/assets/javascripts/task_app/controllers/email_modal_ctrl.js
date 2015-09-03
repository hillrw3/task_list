angular.module('taskApp').controller('emailModalCtrl', ['$scope', '$modalInstance', 'List', function ($scope, $modalInstance, List) {
  $scope.send = function send() {
    List.email({recipients: $scope.recipients});

    $modalInstance.dismiss();
    $scope.recipients = undefined;
  };

  $scope.cancel = function () {
    $modalInstance.dismiss('cancel');
  };
}]);