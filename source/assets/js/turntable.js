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

    //  When a State is added to Phaser it automatically has the following properties set on it, even if they already exist:

    this.add;       //  used to add sprites, text, groups, etc
    this.camera;    //  a reference to the game camera
    this.cache;     //  the game cache
    this.input;     //  the global input manager (you can access this.input.keyboard, this.input.mouse, as well from it)
    this.load;      //  for preloading assets
    this.math;      //  lots of useful common math operations
    this.sound;     //  the sound manager - add a sound, play one, set-up markers, etc
    this.stage;     //  the game stage
    this.time;      //  the clock
    this.tweens;    //  the tween manager
    this.world;     //  the game world
    this.particles; //  the particle manager
    this.physics;   //  the physics manager
    this.rnd;       //  the repeatable random number generator
    this.ready = true;
    this.award = '';
    this.costText;
    this.pointsText;
    this.gameoverText;
    this.gameoverGroup;
    this.descobj;
    this.remainNum;
    this.scrollY = false;
    this.enableScroll;

    //  You can use any of these from any function within this State.
    //  But do consider them as being 'reserved words', i.e. don't create a property for your own game called "world" or you'll over-write the world reference.

};

BasicGame.Game.prototype = {

    create: function () {
        var turnGroup = game.add.group();
        var turntableCache = this.cache.getImage('turntable');
        circleX = game.width / 2;
        circleY = 100 + turntableCache.height / 2;
        this.turntable = turnGroup.create(circleX, circleY, 'turntable');
        this.turntable.anchor.setTo(0.5);

        var midPannel = turnGroup.create(circleX - 92, circleY - 123, 'mid-pannel');

        var lotteryButton = game.add.button(circleX, circleY, 'lottery', this.lottery, this);
        lotteryButton.anchor.setTo(0.5);
        turnGroup.add(lotteryButton);

        this.remainNum = 0;
        if (isLogin) {
            this.remainNum = freeNum - todayNum;
        } else if (!isLogin && !!localStorage) {
            var today = new Date().toLocaleDateString();
            todayTimes = localStorage.getItem('todayTimes');
            lastDay = localStorage.getItem('lastDay');
            if (!lastDay || today != lastDay) {
                todayTimes = 0;
            }
            this.remainNum = freeNum - todayTimes;
        }

        this.costText = game.add.text(game.world.centerX, circleY + 65, '', { font: "16px Arial", fill: "#ffffff", align: "center" }, turnGroup);
        this.costText.anchor.setTo(0.5);
        this.showCost();

        this.add.sprite(0, 0, 'panel');
        // game.add.text(game.world.centerX, 20, nickname, { font: "20px Arial", fill: "#000000"}, turnGroup).anchor.setTo(0.5, 0);
        this.add.text(game.world.centerX, 10, '大转盘', { font: "30px Arial", fill: "#000000"}).anchor.setTo(0.5, 0);
        if (isLogin) this.pointsText = this.add.text(260, 15, userpoints, { font: "20px Arial", fill: "#000000"});

        desc = desc.replace(/###/g,"\n");
        descText = game.add.text(22, 482, desc, { font: "20px Arial", fill: "#000000" });
        descY = 450;
        game.add.sprite(10, descY, 'desc-header');
        descY += 31;
        for (i = 1; i <= Math.ceil(descText.getLocalBounds().height / 9); i++) {
            game.add.sprite(10, descY, 'desc-body');
            descY += 9;
        }
        game.add.sprite(10, descY, 'desc-footer');
        game.world.bringToTop(descText);

        if (descText.getLocalBounds().height > 40) {
            var myHeight = 500 + descText.getLocalBounds().height;
            this.enableScroll = true;
            game.world.setBounds(0, 0, 360, myHeight);
            game.inputEnabled = true;
            game.input.onDown.add(this.beginScroll, this);
        } else {
            this.enableScroll = false;
        }

        // gameover group
        this.gameoverGroup = game.add.group();
        this.gameoverGroup.visible = false;
        var style = { font: "bold 25px Arial", fill: "#0000FF", align: "center" };

        this.gameoverText = game.add.text(game.world.centerX, 85, '', style, this.gameoverGroup);
        this.gameoverText.anchor.setTo(0.5);
    },

    update: function () {
        if (this.enableScroll && game.input.activePointer.isDown) {
            game.camera.y += this.scrollY - game.input.activePointer.y;
            this.scrollY = game.input.activePointer.y;
        }
        //  Honestly, just about anything could go here. It's YOUR game after all. Eat your heart out!

    },

    beginScroll: function () {
        this.scrollY = game.input.activePointer.y;
    },

    showCost: function () {
        if (this.remainNum > 0) {
            this.costText.setText('免费(' + this.remainNum + ') ');
        } else {
            this.costText.setText('每次' + consumePoints + '积分');
        }
    },

    lottery: function () {
        if (this.ready) {
            this.gameoverGroup.visible = false;
            var _self = this;
            ajax({
                url: '/turntable/lottery',
                data: {},
                onSuccess: function(data) {
                    var resp = JSON.parse(data);
                    if (resp.code == 0) {
                        _self.award = resp.data.award;
                        _self.turn(+resp.data.angle);
                    } else {
                        ajaxError(resp.code);
                    }
                },
            });
        }
    },

    turn: function (turnAngle) {
        if (isLogin) {
            if (this.remainNum > 0) {
                this.remainNum--;
                this.showCost();
            } else {
                userpoints -= consumePoints;
                if (userpoints < 0) {
                    sweetAlert('您的积分不够');
                    return;
                }
                this.pointsText.setText(userpoints);
            }
        }
        if(!isLogin && !!localStorage) {
            var today = new Date().toLocaleDateString();
            todayTimes = localStorage.getItem('todayTimes');
            lastDay = localStorage.getItem('lastDay');
            if (!lastDay || today != lastDay) {
                todayTimes = 0;
            }

            if (todayTimes >= freeNum) {
                sweetAlert('请登录');
                return;
            }

            localStorage.setItem('todayTimes', ++todayTimes);
            localStorage.setItem('lastDay', today);
            if (this.remainNum > 0) {
                this.remainNum--;
                this.showCost();
            }
        }
        this.ready = false;

        this.turntable.angle = 0;
        var circle = this.rnd.integerInRange(3, 8);
        var duration = this.rnd.integerInRange(2000, 3000);
        turnAngle = 360 * circle - turnAngle;
        var tw = game.add.tween(this.turntable).to({angle: turnAngle}, duration, Phaser.Easing.Circular.Out, true);
        tw.onComplete.add(this.endlottery, this);
    },

    endlottery: function () {
        this.ready = true;
        if (this.award == '') {
            var awardText = '很遗憾，未中奖';
        } else {
            var awardText = '恭喜，中了' + this.award + '！';
        }
        this.gameoverText.setText(awardText);
        this.gameoverGroup.visible = true;
    },
};

//  Add the States your game has.
//  You don't have to do this in the html, it could be done in your Boot state too, but for simplicity I'll keep it here.
game.state.add('Boot', BasicGame.Boot);
game.state.add('Preloader', BasicGame.Preloader);
game.state.add('Game', BasicGame.Game);

//  Now start the Boot state.
game.state.start('Boot');
