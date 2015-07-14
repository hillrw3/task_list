angular.module('taskApp').controller('tasksCtrl', ['$scope', function ($scope) {
    $scope.newTask = '';
    $scope.taskList = [];

    $scope.addTask = function addTask() {
      if($scope.newTask != '') {
        $scope.taskList.push($scope.newTask);
        $scope.newTask = '';
      }
    };

    $scope.removeTask = function removeTask(task) {
      var index = $scope.taskList.indexOf(task);
      if (index > -1) {
        $scope.taskList.splice(index, 1);
      }
    }
  }]
);