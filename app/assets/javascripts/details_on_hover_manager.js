// function DetailsOnHoverManager (argument) {
//   this.$body = $('body');
//   this.$parentContainers = this.$body.find('.' + argument.parentContainersClass);
//   this.hoverInfoContainersClass = argument.hoverInfoContainersClass;
// };

// DetailsOnHoverManager.prototype.init = function() {
//   this.bindEvents();
// };

// DetailsOnHoverManager.prototype.bindEvents = function() {
//   var _this = this;
//   this.$parentContainers.on('mouseover', function(){
//     $(this).find('.' + _this.hoverInfoContainersClass).show();
//   });

//   this.$parentContainers.on('mouseout', function(){
//     $(this).find('.' + _this.hoverInfoContainersClass).hide();
//   });
// };

// $(function() {
//   var argument = { parentContainersClass: 'response-container',
//                     hoverInfoContainersClass: 'hover-info' };
//   var obj1 = new DetailsOnHoverManager(argument);
//   obj1.init();
// });
