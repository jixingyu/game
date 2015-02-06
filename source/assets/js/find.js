function findmap(w, h, boxes) {
	this.root = {
		x : 0,
		y : 40,
		w : w,
		h : h
	}; //初始化二叉树根节点
	this.init(boxes)
};

findmap.prototype = {
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
        game.stage.backgroundColor = '#ffffff';//document.body.bgColor;

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

        this.load.image('menu-header','assets/find/menu-header.png');
        this.load.image('menu-mid','assets/find/menu-mid.png');
        this.load.image('menu-footer','assets/find/menu-footer.png');
        this.load.image('start','assets/find/start.png');

        this.load.image('header','assets/find/header.png');
        this.load.image('footer','assets/find/footer.png');
        this.load.image('prompt','assets/find/prompt.png');
        this.load.image('add-time','assets/find/add-time.png');
        this.load.image('gamepoints','assets/gamepoints.png');

        this.load.json('sconfig', '/find/config');

        var testImage = ['1.png','2.png','3.png','4.png','5.png','6.png','7.png','8.png','9.png','10.png','11.png','6060.png'];
        for (i=0;i<50;i++) {
            var j = this.rnd.integerInRange(0, testImage.length - 1);
            this.load.image('test'+i,'assets/find/images/test/'+testImage[j]);
        }
    },

    create: function () {
        this.preloadBar.cropEnabled = false;
        this.state.start('MainMenu');
    },
};

BasicGame.MainMenu = function (game) {

    this.music = null;
    this.playButton = null;
    this.scrollY;
    this.enableScroll;
};

BasicGame.MainMenu.prototype = {

    create: function () {this.startGame();
        this.add.sprite(0, 0, 'menu-header');
        var grouppoints = this.add.group();
        grouppoints.create(0, 100, 'gamepoints');
        this.pointsText = this.add.text(45, 100, userpoints, { font: "20px Arial", fill: "#ffffff" }, grouppoints);
        grouppoints.x = (game.world.width - grouppoints.width) / 2;

        var desc = this.cache.getJSON('sconfig').data.desc;
        descText = game.add.text(40, 160, desc, { font: "20px Arial", fill: "#000000" });
        var loopmid = 0;
        descY = 280;
        if (descText.getLocalBounds().height > 250) {
            this.enableScroll = true;
            for (i = 1; i <= Math.ceil((descText.getLocalBounds().height - 250) / 20); i++) {
                game.add.sprite(0, descY, 'menu-mid');
                descY += 20;
                loopmid++;
            }
        } else {
            this.enableScroll = false;
        }
        game.add.sprite(0, descY, 'menu-footer');
        game.world.bringToTop(descText);

        if (this.enableScroll) {
            game.world.setBounds(0, 0, 360, 540+20*loopmid);
            game.inputEnabled = true;
            game.input.onDown.add(this.beginScroll, this);
        }

        this.add.button(game.world.centerX, descY + 170, 'start', this.startGame, this).anchor.setTo(0.5, 0);

    },

    update: function () {
        if (this.enableScroll && game.input.activePointer.isDown) {
            game.camera.y += this.scrollY - game.input.activePointer.y;
            this.scrollY = game.input.activePointer.y;
        }
    },

    beginScroll: function () {
        this.scrollY = game.input.activePointer.y;
    },

    startGame: function () {
        this.state.start('Game');
    }

};

BasicGame.Game = function (game) {
    this.ready = false;
    this.scrollY = false;
    this.usedImages = [];
    this.leftImages = [];
};

BasicGame.Game.prototype = {

    init: function () {
        this.currentLevel = 0;
        this.promptTimes = 0;
        this.addtTimes = 0;
        this.currentId = 0;
        this.ready = false;
        this.addPointsText = null;

        this.sconfig = this.cache.getJSON('sconfig');
        this.sconfig = this.sconfig.data;

        this.remainTime = parseInt(this.sconfig.i);
        this.sconfig.fr = parseInt(this.sconfig.fr);
        this.sconfig.rp = parseInt(this.sconfig.rp);
        this.sconfig.mr = parseInt(this.sconfig.mr);
        this.sconfig.at = parseInt(this.sconfig.at);
        this.sconfig.st = parseInt(this.sconfig.st);
        this.sconfig.t  = parseInt(this.sconfig.t);
        this.sconfig.tp = parseInt(this.sconfig.tp);
        this.sconfig.mt = parseInt(this.sconfig.mt);
    },

    create: function () {

        imgs=[];
        for (i=0;i<50;i++) {
            imgs.push({w:this.cache.getImage('test'+i).width,h:this.cache.getImage('test'+i).height});
        }

        game.world.setBounds(0, 0, 360, 900);
        game.inputEnabled = true;
        game.input.onDown.add(this.beginScroll, this);
        var newMap = new findmap(360, 810, imgs);
console.log(imgs);
        for (var n = 0; n < imgs.length; n++) {
            var img = imgs[n];
            if (img.fit) {
                this.usedImages.push[img];
                this.add.button(img.x, img.y, 'test'+n);
            } else {
                this.leftImages.push[img];
            }
        }

        this.header = this.add.sprite(0, 0, 'header');
        this.footer = this.add.sprite(0, 491, 'footer');
        this.header.fixedToCamera = true;
        this.footer.fixedToCamera = true;

        this.add.button(10, 500, 'prompt', this.promptOnce, this);
        this.add.button(102, 500, 'add-time', this.addTime, this);
        this.promptText = this.add.text(53, 506, this.sconfig.fr, {font: "15px Arial", fill: "#ffffff"});
        this.levelText = this.add.text(305, 22, '', {font: "28px Arial", fill: "#ffffff"});
        this.levelText.anchor.setTo(0.5);
        // this.ready = true;
    },

    topHeadFoot: function () {
        game.world.bringToTop(this.header);
        game.world.bringToTop(this.footer);
    },

    promptOnce: function () {
        if (!this.ready) {
            return;
        }
        if (this.promptTimes >= this.sconfig.fr + this.sconfig.mr) {
            sweetAlert('每轮最多购买' + this.sconfig.mr + '次提醒');
        } else if (this.promptTimes >= this.sconfig.fr) {
            if (this.userPoints < this.sconfig.rp) {
                sweetAlert('您的积分不够');
                return;
            } else {
                var _self = this;
                ajax({
                    url: '/spot/prompt',
                    data: {i:this.currentId},
                    onSuccess: function(data) {
                        var resp = JSON.parse(data);
                        if (resp.code == 0) {
                            _self.userPoints -= _self.sconfig.rp;
                            if (_self.found < 4) {
                                _self.showPoints('-' + _self.sconfig.rp);
                            }
                            _self.doPrompt();
                        } else {
                            ajaxError(resp.code);
                        }
                    },
                });
            }
        } else {
            this.promptText.setText(this.sconfig.fr - this.promptTimes - 1);
            this.doPrompt();
        }
    },

    doPrompt: function () {
        this.promptTimes++;
        promptpoint = this.currentImage.coordinate.pop();
        this.circles.drawCircle(promptpoint.x, 44 + promptpoint.y, promptpoint.iradius * 2);
        this.circles.drawCircle(promptpoint.x, 274 + promptpoint.y, promptpoint.iradius * 2);
        this.found++;

        if (this.found == 5) {
            this.finishOne();
        }
    },

    addTime: function () {
        if (!this.ready) {
            return;
        }
        if (this.addtTimes >= this.sconfig.mt) {
            sweetAlert('每轮最多加时' + this.sconfig.mt + '次');
        } else if (this.userPoints < this.sconfig.t) {
            sweetAlert('您的积分不够');
            return;
        } else {
            var _self = this;
            ajax({
                url: '/spot/timer',
                data: {i:this.currentId},
                onSuccess: function(data) {
                    var resp = JSON.parse(data);
                    if (resp.code == 0) {
                        _self.userPoints -= _self.sconfig.tp;
                        _self.remainTime += _self.sconfig.t;
                        _self.showPoints('-' + _self.sconfig.tp);
                        _self.addtTimes++;
                    } else {
                        ajaxError(resp.code);
                    }
                },
            });
        }
    },

    update: function () {
        if (game.input.activePointer.isDown) {
            game.camera.y += this.scrollY - game.input.activePointer.y;
            this.scrollY = game.input.activePointer.y;
        }
    },

    beginScroll: function () {
        this.scrollY = game.input.activePointer.y;
    },
};

//  Add the States your game has.
//  You don't have to do this in the html, it could be done in your Boot state too, but for simplicity I'll keep it here.
game.state.add('Boot', BasicGame.Boot);
game.state.add('Preloader', BasicGame.Preloader);
game.state.add('MainMenu', BasicGame.MainMenu);
game.state.add('Game', BasicGame.Game);

//  Now start the Boot state.
game.state.start('Boot');
