angular.module('taskApp').controller('tasksCtrl', ['$scope', function ($scope) {
    $scope.taskList = [];

    $scope.addTask = function addTask() {
      $scope.taskList.push($scope.newTask);
      $scope.newTask = '';
    };
  }]
);