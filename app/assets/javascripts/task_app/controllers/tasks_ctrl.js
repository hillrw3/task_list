angular.module('taskApp').controller('tasksCtrl', ['$scope', function ($scope) {
    $scope.newTask = '';
    $scope.taskList = [];

    $scope.addTask = function addTask() {
      if($scope.newTask != '') {
        $scope.taskList.push($scope.newTask);
        $scope.newTask = '';
      }
    };
  }]
);