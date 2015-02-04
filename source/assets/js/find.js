function sprite(w, h, boxes) {
	this.root = {
		x : 0,
		y : 0,
		w : w,
		h : h
	}; //初始化二叉树根节点
	this.init(boxes)
};

sprite.prototype = {
	init : function (boxes) {
		var i;
		for (i = 0; i < boxes.length; i++) {
			var block = boxes[i];
			var node = this.travel(this.root, block.w, block.h) //利用递归从根节点开始遍历二叉树,判断节点大小是否足够
				//console.log(node)
				if (node) { //如果节点大小足够
					this.markAndCutNode(node, block.w, block.h) //给节点做标记，并拆分成右侧与下测
					block.fit = true; //给小盒子做标记，并记录位置信息
					block.x = node.x;
					block.y = node.y;
				};
		}
	},
	//遍历二叉树
	travel : function (root, w, h) {
		if (root.filled) //已经放入盒子了，继续遍历子节点
			return this.travel(root.right, w, h) || this.travel(root.down, w, h); //遍历右边与下边
		else if ((w <= root.w) && (h <= root.h)) { //节点足够大,返回节点
			return root
		} else {
			return null
		}
	},
	//标记并拆分节点
	markAndCutNode : function (node, w, h) {
		node.filled = true; //标记节点为装入盒子状态
		node.down = {
			x : node.x,
			y : node.y + h,
			w : node.w,
			h : node.h - h
		}; //标记下侧出来
		node.right = {
			x : node.x + w,
			y : node.y,
			w : node.w - w,
			h : h
		}; //标记右侧出来
	}
	
}

var game = new Phaser.Game(360, 540, Phaser.AUTO, 'game');

BasicGame = {

    /* Here we've just got some global level vars that persist regardless of State swaps */
    // score: 0,

    /* If the music in your game needs to play through-out a few State swaps, then you could reference it here */
    // music: null,

    /* Your game can check BasicGame.orientated in internal loops to know if it should pause or not */
    // orientated: false

};

BasicGame.Boot = function (game) {
};

BasicGame.Boot.prototype = {

    init: function () {
        game.stage.backgroundColor = document.body.bgColor;

        this.input.maxPointers = 1;
        this.stage.disableVisibilityChange = true;
        this.scale.parentIsWindow = true;

        this.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL;

        this.scale.pageAlignHorizontally = true;
        this.scale.pageAlignVertically = true;
    },

    preload: function () {

        //  Here we load the assets required for our preloader (in this case a background and a loading bar)
        this.load.image('preloaderBar', 'assets/preloader.png');
        this.load.image('preloaderbar-bottom', 'assets/preloader-bottom.png');

    },

    create: function () {

        this.state.start('Preloader');

    },
};



BasicGame.Preloader = function (game) {
    this.preloadBar = null;

    this.ready = false;

};

BasicGame.Preloader.prototype = {

    preload: function () {
        this.add.sprite(55, 250, 'preloaderbar-bottom');
        this.preloadBar = this.add.sprite(58, 257, 'preloaderBar');

        this.load.setPreloadSprite(this.preloadBar);

        this.load.image('turntable',turntableImage);
        this.load.image('panel','assets/turntable/panel.png');
        this.load.image('lottery','assets/turntable/start-button1.png');
        this.load.image('press','assets/turntable/press-button.png');
        this.load.image('mid-pannel','assets/turntable/mid.png');
        this.load.image('desc-header','assets/turntable/desc-header.png');
        this.load.image('desc-body','assets/turntable/desc-body.png');
        this.load.image('desc-footer','assets/turntable/desc-footer.png');
    },

    create: function () {

        //  Once the load has finished we disable the crop because we're going to sit in the update loop for a short while as the music decodes
        this.preloadBar.cropEnabled = false;

    },

    update: function () {

        if (this.ready == false)
        {
            this.ready = true;
            this.state.start('Game');
        }

    }

};

BasicGame.Game = function (game) {
    this.ready = true;
    this.scrollY = false;
};

BasicGame.Game.prototype = {

    create: function () {

    },

    update: function () {
        if (game.input.activePointer.isDown) {
            game.camera.y += this.scrollY - game.input.activePointer.y;
            this.scrollY = game.input.activePointer.y;
        }
        //  Honestly, just about anything could go here. It's YOUR game after all. Eat your heart out!

    },

    beginScroll: function () {
        this.scrollY = game.input.activePointer.y;
    },
};

//  Add the States your game has.
//  You don't have to do this in the html, it could be done in your Boot state too, but for simplicity I'll keep it here.
game.state.add('Boot', BasicGame.Boot);
game.state.add('Preloader', BasicGame.Preloader);
game.state.add('Game', BasicGame.Game);

//  Now start the Boot state.
game.state.start('Boot');
