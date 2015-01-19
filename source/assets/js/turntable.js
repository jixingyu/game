var game = new Phaser.Game(720, 1080, Phaser.AUTO, 'game');
var points = 500;
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
        this.add.sprite(100, 500, 'preloaderbar-bottom');
        this.preloadBar = this.add.sprite(106.5, 513.5, 'preloaderBar');

        this.load.setPreloadSprite(this.preloadBar);

        this.load.image('turntable',turntableImage);
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

    //  You can use any of these from any function within this State.
    //  But do consider them as being 'reserved words', i.e. don't create a property for your own game called "world" or you'll over-write the world reference.

};

BasicGame.Game.prototype = {

    create: function () {
        var turnGroup = game.add.group();
        var turntableCache = this.cache.getImage('turntable');
        circleX = game.width / 2;
        circleY = 180 + turntableCache.height / 2;
        this.turntable = turnGroup.create(circleX, circleY, 'turntable');
        this.turntable.anchor.setTo(0.5,0.5);

        var midPannel = turnGroup.create(circleX - 184, circleY - 247, 'mid-pannel');

        var lotteryButton = game.add.button(circleX, circleY, 'lottery', this.lottery, this);
        lotteryButton.anchor.setTo(0.5,0.5);
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

        this.costText = game.add.text(game.world.centerX, circleY + 130, '', { font: "32px Arial", fill: "#ffffff", align: "center" }, turnGroup);
        this.costText.anchor.setTo(0.5);
        this.showCost();

        var nickname = game.add.text(game.world.centerX, 40, '王小明', { font: "40px Arial", fill: "#000000"}, turnGroup);
        nickname.anchor.setTo(0.5, 0);
        this.pointsText = game.add.text(600, 40, points, { font: "40px Arial", fill: "#000000"}, turnGroup);

        desc = desc.replace(/###/g,"\n");
        descText = game.add.text(30, 945, desc, { font: "25px Arial", fill: "#000000" });
        descY = 880;
        game.add.sprite(3, descY, 'desc-header');
        descY += 61;
        for (i = 1; i <= Math.ceil(descText.getLocalBounds().height / 17); i++) {
            game.add.sprite(3, descY, 'desc-body');
            descY += 17;
        }
        game.add.sprite(3, descY, 'desc-footer');
        // descPanel.scale.y = (descText.getLocalBounds().height + 100) / 331;
        game.world.bringToTop(descText);

        // descText.inputEnabled = true;
        // descText.input.enableDrag();
        // descText.input.allowHorizontalDrag = false;
        // descPanel = new Phaser.Rectangle(100, 880, 10, descText.getLocalBounds().height);game.debug.geom(descPanel,'#000000');

        if (descText.getLocalBounds().height > 80) {
            var myHeight = 1000 + descText.getLocalBounds().height;
        } else {
            var myHeight = 1080;
        }
        game.world.setBounds(0, 0, 720, myHeight);
        game.inputEnabled = true;
        game.input.onDown.add(this.beginScroll, this);

        // gameover group
        this.gameoverGroup = game.add.group();
        this.gameoverGroup.visible = false;
        var style = { font: "50px Arial", fill: "#0000FF", align: "center" };

        this.gameoverText = game.add.text(game.world.centerX, 140, '', style, this.gameoverGroup);
        this.gameoverText.anchor.setTo(0.5);
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

    showCost: function () {
        if (this.remainNum > 0) {
            this.costText.setText('免费(' + this.remainNum + ')');
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
                points -= consumePoints;
                if (points < 0) {
                    alert('积分不够');
                    return;
                }
                this.pointsText.setText(points);
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
                alert('请登录');
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
