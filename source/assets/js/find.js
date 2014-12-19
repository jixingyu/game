listenSwipe(function(direction) {
	console.log(direction);
});

function listenSwipe(callback) {
	var eventDuration;
	var startPoint = {};
	var endPoint = {};
	var direction;
	var minimum = {
		duration: 75,
		distance: 150
	}

	game.input.onDown.add(function(pointer) {
		startPoint.x = pointer.clientX;
		startPoint.y = pointer.clientY;
	}, this);

	game.input.onUp.add(function(pointer) {
		direction = '';
		eventDuration = game.input.activePointer.duration;

		if (eventDuration > minimum.duration) {
			endPoint.x = pointer.clientX;
			endPoint.y = pointer.clientY;

			// Check direction
			if (endPoint.x - startPoint.x > minimum.distance) {
				direction = 'right';
			} else if (startPoint.x - endPoint.x > minimum.distance) {
				direction = 'left';
			} else if (endPoint.y - startPoint.y > minimum.distance) {
				direction = 'bottom';
			} else if (startPoint.y - endPoint.y > minimum.distance) {
				direction = 'top';
			}

			if (direction) {
				callback(direction);
			}
		}
	}, this);
};