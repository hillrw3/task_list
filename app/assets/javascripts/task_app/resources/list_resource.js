angular.module('taskApp').factory('List', ['$resource', function ($resource) {
  return $resource('/lists.json', {}, {
    query: {isArray: false},
    email: {method: 'POST',
      url: '/email_list'
    }
  });
}]);