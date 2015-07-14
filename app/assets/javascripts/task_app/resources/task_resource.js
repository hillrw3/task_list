angular.module('taskApp').factory('Task', ['$resource', function ($resource) {
  return $resource('/tasks.json', {}, {

  });
}]);