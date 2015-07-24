angular.module('taskApp').factory('Task', ['$resource', function ($resource) {
  return $resource('/tasks/:id.json', {}, {
    query: {isArray: false},
    finish: {method: 'PATCH',
      isArray: false,
      url: '/tasks/:id/finish',
      params: {id: '@id'}
    },
    delete: {method: 'DELETE'},
    restart: {method: 'PATCH',
      isArray: false,
      url: '/tasks/:id/restart',
      params: {id: '@id'}
    }
  });
}]);