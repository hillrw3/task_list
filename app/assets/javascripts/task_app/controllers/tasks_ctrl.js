angular.module('taskApp').controller('tasksCtrl', ['$scope', 'Task', function ($scope, Task) {

    $scope.init = function init() {
      $scope.newTask = {description: ''};

      Task.query().$promise.then(function(data) {
        $scope.startedTasks = data.started || [];
        $scope.finishedTasks = data.finished || [];
      });
    };

    $scope.addTask = function addTask() {
      if($scope.newTask.description!= '') {
        Task.save({description: $scope.newTask.description}).$promise.then(function(data) {
          $scope.startedTasks.push(data);
          $scope.newTask.description = '';
        });
      }
    };

    $scope.finishTask = function finishTask(task) {
      Task.finish({id: task.id}).$promise.then(function() {
        var index = $scope.startedTasks.indexOf(task);
        if (index > -1) {
          $scope.startedTasks.splice(index, 1);
        }
        $scope.finishedTasks.push(task)
      })
    };

    $scope.deleteTask = function deleteTask(task) {
      Task.delete({id: task.id}).$promise.then(function() {
        var index = $scope.finishedTasks.indexOf(task);
        if (index > -1) {
          $scope.finishedTasks.splice(index, 1);
        }
      })
    };

    $scope.restartTask = function restartTask(task) {
      Task.restart({id: task.id}).$promise.then(function(data) {
        var index = $scope.finishedTasks.indexOf(task);
        if (index > -1) {
          $scope.finishedTasks.splice(index, 1);
        }
        $scope.startedTasks.push(task)
      })
    };
  }]
);