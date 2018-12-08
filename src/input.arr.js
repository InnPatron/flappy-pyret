var spacePressed = false;

window.addEventListener("keypress", function(e) {
  if (e.key === ' ') {
    spacePressed = true;
  }
})
module.exports = {
  'query-input': function() {
    var ret = { space: spacePressed };
    spacePressed = false;

    return ret;
  }
};
