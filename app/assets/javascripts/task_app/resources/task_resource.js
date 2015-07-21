angular.module('taskApp').factory('Task', ['$resource', function ($resource) {
  return $resource('/tasks/:id.json', {}, {
    finish: {method: 'PATCH',
      isArray: false,
      url: '/tasks/:id/finish',
      params: {id: '@id'}
    }
  });
}]);