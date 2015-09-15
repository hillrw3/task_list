angular.module('taskApp').factory('List', ['$resource', function ($resource) {
  return $resource('/lists', {}, {
    query: {isArray: true},
    email: {method: 'POST',
      url: '/email_list'
    },
    delete: {method: 'DELETE',
      url: '/lists/:id'}
  });
}]);