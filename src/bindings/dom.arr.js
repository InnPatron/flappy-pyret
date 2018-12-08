module.exports = {
  "get-element": function(id) {
    return document.getElementById(id);
  },

  "modify-element": function(element, property, value) {
    element[property] = value;
  },
};
