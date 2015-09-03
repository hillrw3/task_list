angular.module('taskApp').controller('tasksCtrl', ['$scope', '$modal', 'Task', 'List', function ($scope, $modal, Task, List) {

    $scope.init = function init() {
      $scope.newTask = {description: ''};

      List.query().$promise.then(function(data) {
        $scope.list = data;
      });
    };

    $scope.addTask = function addTask() {
      if($scope.newTask.description!= '') {
        Task.save({description: $scope.newTask.description, list_id: $scope.list.id}).$promise.then(function(data) {
          $scope.list.started_tasks.push(data);
          $scope.newTask.description = '';
        });
      }
    };

    $scope.finishTask = function finishTask(task) {
      Task.finish({id: task.id}).$promise.then(function() {
        var index = $scope.list.started_tasks.indexOf(task);
        if (index > -1) {
          $scope.list.started_tasks.splice(index, 1);
        }
        $scope.list.finished_tasks.push(task)
      })
    };

    $scope.deleteTask = function deleteTask(task) {
      Task.delete({id: task.id}).$promise.then(function() {
        var index = $scope.list.finished_tasks.indexOf(task);
        if (index > -1) {
          $scope.list.finished_tasks.splice(index, 1);
        }
      })
    };

    $scope.restartTask = function restartTask(task) {
      Task.restart({id: task.id}).$promise.then(function(data) {
        var index = $scope.list.finished_tasks.indexOf(task);
        if (index > -1) {
          $scope.list.finished_tasks.splice(index, 1);
        }
        $scope.list.started_tasks.push(task)
      })
    };

    $scope.sendEmail = function sendEmail(e) {
      if (e) {
        e.preventDefault();
        e.stopPropagation();
      }

      $modal.open({
        template: JST['task_app/templates/email_modal'](),
        controller: 'emailModalCtrl'
      })
    }
  }]
);