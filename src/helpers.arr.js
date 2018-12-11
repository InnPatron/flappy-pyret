module.exports = {
  'concat-strings': function(list) {
    return list.join("");
  },

  'rng': function(upperInclusive) {
    return (Math.random() * 2 * upperInclusive) - upperInclusive;
  },
};
