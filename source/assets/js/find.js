var testLen = 100;
function matrix(w, h, quene) {
    this.base = {w:30,h:30};

    this.mw = w / this.base.w;
    this.mh = h / this.base.h;
    this.mt = [];

    for (i = 0; i < this.mw; i++) {
        this.mt[i] = [];
        for (j = 0; j < this.mh; j++) {
            this.mt[i][j] = {
                filled: false
            };
        }
    }

    for (k = 0; k < quene.length; k++) {
        point = this.mscan(quene[k]);
        if (point) {
            quene[k].x = point.x * this.base.w;
            quene[k].y = point.y * this.base.h + 40;
            quene[k].active = true;
        } else {
            quene[k].active = false;
        }
    }
}
matrix.prototype = {
    checkFill: function (i, j, row, col) {
        for (m = 0; m < row; m++) {
            for (n = 0; n < col; n++) {
                if (this.mt[i+m][j+n].filled) {
                    return {
                        x: i+m,
                        y: j+n,
                        find: false
                    };
                }
            }
        }
        return {find: true};
    },

    mscan: function (q) {
        var row = q.w / this.base.w;
        var col = q.h / this.base.h;
        limitX = -1;
        limitY = -1;
        for (j = 0; j < this.mh - col + 1; j++) {
            for (i = 0; i < this.mw - row + 1; i++) {
                if (i <= limitX && j <= limitY) {
                    continue;
                }
                res = this.checkFill(i, j, row, col);
                if (res.find) {
                    for (a = i; a < i + row; a++) {
                        for (b = j; b < j + col; b++) {
                            this.mt[a][b].filled = true;
                        }
                    }
                    return {
                        x: i,
                        y: j
                    };
                } else {
                    limitX = res.x;
                    limitY = res.y;
                }
            }
        }
    }
}

var game = new Phaser.Game(360, 540, Phaser.AUTO, 'game');

BasicGame = {
    tags: [],
    imageTags: []

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
        this.load.json('sconfig', '/find/config');
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

        var simages = this.cache.getJSON('sconfig').data.images;
        BasicGame.tags = this.cache.getJSON('sconfig').data.tags;
        if (!simages || simages.length <= 0) {
            sweetAlert('请检查网络');
            return;
        }

        for (i=0;i<testLen;i++) {
            var j = this.rnd.integerInRange(0, simages.length - 1);
            this.load.image('image' + i,'assets/find/images/'+simages[j].file_name);
            BasicGame.imageTags[i] = simages[j].tags.split(",");
        }
        this.ready = true;
    },

    create: function () {
        if (this.ready) {
            this.preloadBar.cropEnabled = false;
            this.state.start('MainMenu');
        }
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
    this.activeImages = [];
    this.deathImages = [];
};

BasicGame.Game.prototype = {

    init: function () {
        this.currentLevel = 0;
        this.currentTag = '';
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
        for (i=0;i<testLen;i++) {
            imgs.push({
                w:this.cache.getImage('image'+i).width,
                h:this.cache.getImage('image'+i).height
            });
        }

        game.world.setBounds(0, 0, 360, 900);
        game.inputEnabled = true;
        game.input.onDown.add(this.beginScroll, this);

        var mt = new matrix(360, 900, imgs);

        for (var i = 0; i < imgs.length; i++) {
            var img = imgs[i];
            if (img.active) {
                img.imgIndex = i;
                this.activeImages.push(img);
                var sp = this.add.sprite(img.x, img.y, 'image'+i);
                sp.imgIndex = i;
                sp.inputEnabled = true;
                sp.events.onInputDown.add(this.checkBegin, this);
                sp.events.onInputUp.add(this.check, this);
            } else {
                this.deathImages.push(img);
            }
        }

        this.uiframe = this.add.group();
        this.uiframe.create(0, 0, 'header');
        this.uiframe.create(0, 491, 'footer');
        this.uiframe.fixedToCamera = true;

        this.uiframe.add(this.add.button(10, 503, 'prompt', this.promptOnce, this));
        this.uiframe.add(this.add.button(102, 503, 'add-time', this.addTime, this));
        this.promptText = this.add.text(54, 506, this.sconfig.fr, {font: "15px Arial", fill: "#ffffff"});
        this.levelText = this.add.text(305, 22, '', {font: "20px Arial", fill: "#ffffff"});
        this.levelText.anchor.setTo(0.5);
        this.taskText = this.add.text(50, 22, '', {font: "20px Arial", fill: "#000000"});
        this.taskText.anchor.setTo(0.5);
        this.uiframe.add(this.promptText);
        this.uiframe.add(this.levelText);
        this.uiframe.add(this.taskText);

        this.timeText = this.add.text(300, 503, this.getRTime(), {font: "21px Arial", fill: "#000000"});
        this.remainTimer = game.time.events.loop(Phaser.Timer.SECOND, this.updateTime, this);
        this.uiframe.add(this.timeText);
        this.nextLevel();
        this.ready = true;
    },

    nextLevel: function () {
        this.currentLevel++;
        var j = this.rnd.integerInRange(0, this.activeImages.length - 1);
        var k = this.rnd.integerInRange(0, BasicGame.imageTags[this.activeImages[j].imgIndex].length - 1);
        this.currentTag = BasicGame.imageTags[this.activeImages[j].imgIndex][k];
        var n = 0;
        for (i = 0; i < this.activeImages.length; i++) {
            for (m = 0; m < BasicGame.imageTags[this.activeImages[i].imgIndex].length; m++) {
                if (BasicGame.imageTags[this.activeImages[i].imgIndex][m] == this.currentTag) {
                    n++;
                    break;
                }
            }
        }
        n = this.rnd.integerInRange(this.math.floor(n/2), n)
        if (n > 10) {
            n = 10;
        }
        this.levelText.setText('第 ' + this.currentLevel + ' 关');
        this.taskText.setText(BasicGame.tags[this.currentTag] + ' × ' + n);
    },

    checkBegin: function (sprite, pointer) {
        sprite.lastClick = game.time.now;
    },

    check: function (sprite, pointer) {
        if (!this.ready || game.time.now-sprite.lastClick > 600) {
            return;
        }
        for (i = 0; i < BasicGame.imageTags[sprite.imgIndex].length; i++) {
            if (BasicGame.imageTags[sprite.imgIndex][i] == this.currentTag) {
                //TODO
            }
        }
    },

    topHeadFoot: function () {
        game.world.bringToTop(this.header);
        game.world.bringToTop(this.footer);
    },

    getRTime: function () {
        minutes = Math.floor(this.remainTime / 60);
        seconds = this.remainTime % 60;

        if (minutes < 10) minutes = '0' + minutes;
        if (seconds < 10) seconds = '0' + seconds;

        return minutes + ':' + seconds;
    },

    updateTime: function () {
        if (!this.ready) {
            return;
        }
        this.remainTime--;
        if (this.remainTime <= 0) {
            //TODO gameover
            game.time.events.remove(this.remainTimer);
            this.timeText.setText('00:00');
            this.ready = false;
        } else {
            this.timeText.setText(this.getRTime());
        }
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
