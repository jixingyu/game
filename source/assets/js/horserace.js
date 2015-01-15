var game = new Phaser.Game(720, 1280, Phaser.AUTO, 'game');
var horseNum = 8;
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
        if (window.innerWidth) {
            winWidth = window.innerWidth;
            winHeight = window.innerHeight;
        } else if ((document.body) && (document.body.clientWidth)) {
            winWidth = document.body.clientWidth;
            winHeight = document.body.clientHeight;
        } else if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth) {
            winHeight = document.documentElement.clientHeight;
            winWidth = document.documentElement.clientWidth;
        }

        this.input.maxPointers = 1;
        this.stage.disableVisibilityChange = true;
        this.scale.parentIsWindow = true;

        if (winHeight / winWidth > 1.4 && winHeight / winWidth < 2) {
            this.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT;
        } else {
            this.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL;
        }
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

    // gameResized: function (width, height) {

    //     //  This could be handy if you need to do any extra processing if the game resizes.
    //     //  A resize could happen if for example swapping orientation on a device or resizing the browser window.
    //     //  Note that this callback is only really useful if you use a ScaleMode of RESIZE and place it inside your main game state.

    // },

    // enterIncorrectOrientation: function () {

    //     BasicGame.orientated = false;

    //     document.getElementById('orientation').style.display = 'block';

    // },

    // leaveIncorrectOrientation: function () {

    //     BasicGame.orientated = true;

    //     document.getElementById('orientation').style.display = 'none';

    // }

};

BasicGame.Preloader = function (game) {
    this.preloadBar = null;

    this.ready = false;

};

BasicGame.Preloader.prototype = {

    preload: function () {
        this.add.sprite(100, 500, 'preloaderbar-bottom');
        this.preloadBar = this.add.sprite(106.5, 513.5, 'preloaderBar');
        // this.preloadBar.anchor.setTo(0.5,0.5);

        this.load.setPreloadSprite(this.preloadBar);

        for (i = 0; i < horseNum; i++) {
            hid = i + 1;
            game.load.spritesheet('horse' + hid, 'assets/horserace/' + hid + '.png', 245, 120);
        }

        this.load.image('runway-begin','assets/horserace/begin.png');
        this.load.image('runway','assets/horserace/runway.png');
        this.load.image('runway-end','assets/horserace/end.png');
        this.load.image('panel','assets/horserace/panel.png');
        this.load.spritesheet('stand','assets/horserace/stand.png', 175, 110);


        // this.load.audio('hit_ground_sound', 'assets/turntable/ouch.wav');

    },

    create: function () {
        this.preloadBar.cropEnabled = false;
        this.state.start('MainMenu');
    },
};

myChips = {};
myChips.rank = [4,5,6];
myChips.rankPoints = [200,400,300];

BasicGame.MainMenu = function (game) {

    this.music = null;
    this.playButton = null;
};

BasicGame.MainMenu.prototype = {

    create: function () {
        this.startGame();
        // this.add.sprite(0, 0, 'titlepage');

        // this.playButton = this.add.button(400, 600, 'playButton', this.startGame, this, 'buttonOver', 'buttonOut', 'buttonOver');

    },

    update: function () {

        //  Do some nice funky main menu effect here

    },

    addRank: function (i, j) {
        myChips.rank[i - 1] = j;
    },

    addPoints: function (i, j) {
        myChips.rankPoints[i - 1] += j;
    },

    startGame: function () {

        //  Ok, the Play Button has been clicked or touched, so let's stop the music (otherwise it'll carry on playing)
        // this.music.stop();

        var _self = this;
        ajax({
            url: '/horserace/start',
            data: myChips,
            onSuccess: function(data) {
                var resp = JSON.parse(data);
                if (resp.code == 0) {
                    //  And start the actual game
                    _self.state.start('Game', true, false, resp.data.rank);
                }
            },
        });

    }

};


BasicGame.Game = function (game) {
    this.ranklist;
    this.players = [];
    this.balls = [];
    this.panel;
    this.runwayLength = 2160;
    this.runLength = 1800;
    this.startX = 0;
    this.horsePadding = 20;
};

BasicGame.Game.prototype = {

    init: function (ranklist) {
        this.ranklist = ranklist;
        // if (rank1 && ranklist[0] == rank1) {
        //     console.log('win');
        // } else {
        //     console.log('lose');
        // }
    },

    create: function () {
        game.world.setBounds(0, 0, this.runwayLength, 1280);
        game.add.tileSprite(
            0,
            0,
            game.world.width,
            game.height,
            'runway'
        );
        game.add.sprite(100 + this.startX, 217, 'runway-begin');
        game.add.sprite(this.startX + this.runLength + 245 - this.horsePadding, 217, 'runway-end');

        this.panel = game.add.group();
        this.panel.create(0, 0, 'panel');
        this.panel.fixedToCamera = true;
        this.panel.cameraOffset.x = 0;
        this.panel.cameraOffset.y = 0;

        var style = { font: "23px Arial", fill: "#000000" };
        game.add.text(80, 100, '    ' + myChips['rank'][0] + '号马\n下注' + myChips['rankPoints'][0] + '积分', style, this.panel);
        game.add.text(300, 100, '    ' + myChips['rank'][1] + '号马\n下注' + myChips['rankPoints'][1] + '积分', style, this.panel);
        game.add.text(530, 100, '    ' + myChips['rank'][2] + '号马\n下注' + myChips['rankPoints'][2] + '积分', style, this.panel);

        var y = 188;
        // var by = 10;
        for (i = 0; i < horseNum; i++) {
            // this.balls[id] = game.add.sprite(10, by, 'balls', id);
            this.players[i] = game.add.sprite(this.startX, y + 135 * (this.ranklist[i] - 1), 'horse' + this.ranklist[i], 0);
            this.players[i].horseId = this.ranklist[i];
            // by += 20;
        }
        this.runStart();
    },

    runStart: function () {
        var duration = this.rndDuration(7000, 12000);
        // var duration = this.rndDuration(1000, 2000);

        cameraMoveTime = duration[0];

        // var bSectionDistance = 300 / 4;//TODO
        var pSectionDistance = this.runLength / 4;
        // var btween = [];
        var ptween = [];
        tweenLimit = 4;
        for (i = 0; i < horseNum; i++) {
            section = this.rndSection(duration[i], this.runLength, tweenLimit);
            // var btemptween = game.add.tween(this.balls[i].cameraOffset).to({ x: 10 + bSectionDistance }, section[0], Phaser.Easing.Linear.None);
            var ptemptween = game.add.tween(this.players[i]).to({ x: this.startX + pSectionDistance }, section[0], Phaser.Easing.Linear.None);
            for (tweenI = 1; tweenI < tweenLimit; tweenI++) {
                // btemptween.to({ x: 10 + bSectionDistance * (tweenI + 1) }, section[tweenI], Phaser.Easing.Linear.None);
                ptemptween.to({ x: this.startX + pSectionDistance * (tweenI + 1) }, section[tweenI], Phaser.Easing.Linear.None);
            }
            ptemptween.to({ x: game.world.width }, 2000, Phaser.Easing.Linear.None);
            // btween[i] = btemptween;
            ptween[i] = ptemptween;
        }
        for (i = 0; i < horseNum; i++) {
            this.players[i].animations.add('run');
            this.players[i].animations.play('run', 12, true);
            // btween[i].start();
            // ptween[i].onComplete.add(this.runStop, this);
            ptween[i].start();
        }
        game.add.tween(game.camera).to({ x: 1440 }, cameraMoveTime, Phaser.Easing.Linear.None, true);
    },

    runStop: function () {
        for (i = 0; i < horseNum; i++) {
            if (!this.players[i].stopRun && this.players[i].x == this.startX + this.runLength) {
                this.players[i].loadTexture('stand', this.players[i].horseId - 1);
                this.players[i].stopRun = true;
            }
        }
    },

    update: function () {

        //  Honestly, just about anything could go here. It's YOUR game after all. Eat your heart out!

    },

    rndDuration: function (min, max) {
        var r = this.rnd.integerInRange(min, max);
        var array = [];
        for (var i = 0; i < horseNum; i++) {
            var flag = 0;
            do {
                for (var j = 0;j < array.length; j++) {
                    if (array[j] == r) {
                        flag = 1;
                        break;
                    }
                }
                if (!flag) {
                    array[array.length] = r;
                } else {
                    r = this.rnd.integerInRange(min, max);
                }
            } while (!flag);
        }
        array.sort(function(x,y){return x-y}); 
        return array;
    },

    rndSection: function(duration, distance, limit) {
        var t = duration / 4;
        var intT = parseInt(t);
        var minT = parseInt(t * 0.8);
        var maxT = parseInt(t * 1.2);
        var tArray = [];
        var avg = distance / duration;

        for (k = 0; k < limit; k++) {
            if (k == limit - 1) {
                tArray[tArray.length] = duration - eval(tArray.join('+'));
            } else if (k == 3) {
                var sum = eval(tArray.join('+'));
                if (sum / tArray.length > avg) {
                    tArray[tArray.length] = this.rnd.integerInRange(minT, intT);
                } else if (sum / tArray.length < avg) {
                    tArray[tArray.length] = this.rnd.integerInRange(intT, maxT);
                } else {
                    tArray[tArray.length] = this.rnd.integerInRange(minT, maxT);
                }
            } else {
                tArray[tArray.length] = this.rnd.integerInRange(minT, maxT);
            }
        }
        return tArray;
    },

};

//  Add the States your game has.
//  You don't have to do this in the html, it could be done in your Boot state too, but for simplicity I'll keep it here.
game.state.add('Boot', BasicGame.Boot);
game.state.add('Preloader', BasicGame.Preloader);
game.state.add('MainMenu',BasicGame.MainMenu);
game.state.add('Game', BasicGame.Game);

//  Now start the Boot state.
game.state.start('Boot');
