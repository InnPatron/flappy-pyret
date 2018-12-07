module.exports = {
  'create': function() {
    return {};
  },

  'add': function(store, uuid, component) {
    store[uuid] = component;
    return store;
  },

  'get': function(store, uuid) {
    return store[uuid];
  },

  'remove': function(store, uuid) {
    delete(store[uuid]);
  },
};
