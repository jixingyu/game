var game = new Phaser.Game(720, 1280, Phaser.AUTO, 'game');
var horseNum = 6;

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

        this.input.maxPointers = 1;
        this.stage.disableVisibilityChange = true;

        if (this.game.device.desktop)
        {
            this.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL;
            this.scale.setMinMax(480, 260, 1024, 768);
            this.scale.pageAlignHorizontally = true;
            this.scale.pageAlignVertically = true;
            this.scale.setScreenSize(true);
            this.scale.refresh();
        }
        else
        {
            this.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT;
            // this.scale.setMinMax(480, 260, 1024, 768);
            this.scale.pageAlignHorizontally = true;
            this.scale.pageAlignVertically = true;
            // this.scale.forceOrientation(true, false);
            // this.scale.setResizeCallback(this.gameResized, this);
            // this.scale.enterIncorrectOrientation.add(this.enterIncorrectOrientation, this);
            // this.scale.leaveIncorrectOrientation.add(this.leaveIncorrectOrientation, this);
            this.scale.setScreenSize(true);
            this.scale.refresh();
        }

    },

    preload: function () {

        //  Here we load the assets required for our preloader (in this case a background and a loading bar)
        this.load.image('preloaderBar', 'assets/loading.gif');

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
};

BasicGame.Preloader.prototype = {

    preload: function () {
        // game.stage.backgroundColor = '#272822';
        this.preloadBar = this.add.sprite(game.width/2, game.height/2, 'preloaderBar');
        this.preloadBar.anchor.setTo(0.5,0.5);
        this.load.setPreloadSprite(this.preloadBar);

        // this.load.image('turntable','assets/turntable/turntable.png');
        game.load.atlas('horse', 'assets/horserace/horse.png', 'assets/horserace/horse.json');
        game.load.spritesheet('balls', 'assets/horserace/balls.png', 17, 17);


        // this.load.audio('hit_ground_sound', 'assets/turntable/ouch.wav');

    },

    create: function () {
        this.preloadBar.cropEnabled = false;
        this.state.start('MainMenu');
    },
};


rank1=horseNum;
rankPoints1=1*chip;
rank2 = rank3 = 0;

BasicGame.MainMenu = function (game) {

    this.music = null;
    this.playButton = null;
    this.myChips = {};
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

    startGame: function () {

        //  Ok, the Play Button has been clicked or touched, so let's stop the music (otherwise it'll carry on playing)
        // this.music.stop();
        if (rank1) {
            this.myChips.rank1 = rank1;
            this.myChips.rankPoints1 = rankPoints1;
        }
        if (rank2) {
            this.myChips.rank2 = rank2;
            this.myChips.rankPoints2 = rankPoints2;
        }
        if (rank3) {
            this.myChips.rank3 = rank3;
            this.myChips.rankPoints3 = rankPoints3;
        }
        var _self = this;
        ajax({
            url: '/horserace/start',
            data: this.myChips,
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
};

BasicGame.Game.prototype = {

    init: function (ranklist) {
        this.ranklist = [5,4,3,2,1,6];//ranklist;
        // if (rank1 && ranklist[0] == rank1) {
        //     console.log('win');
        // } else {
        //     console.log('lose');
        // }
    },

    create: function () {
        game.world.setBounds(0, 0, 1440, 1280);

        var y = 200;
        var by = 10;
        for (i = 0; i < horseNum; i++) {
            id = i;//this.ranklist[i] - 1;
            this.balls[id] = game.add.sprite(10, by, 'balls', id);
            this.players[id] = game.add.sprite(10, y, 'horse');
            by += 20;
            y += 120;

            this.balls[i].fixedToCamera = true;
            this.balls[i].cameraOffset.x = 10;
            this.balls[i].cameraOffset.y = by;
        }
        this.runStart();
    },

    runStart: function () {
        var duration = this.rndDuration(5000, 9000);

        cameraMoveTime = duration[2];
        // var baseDistance = 720 / cameraMoveTime;

        var bSectionDistance = 300 / 4;//TODO
        var pSectionDistance = 1000 / 4;
        var btween = [];
        var ptween = [];
        tweenLimit = 4;
        for (i = 0; i < 5; i++) {
            section = this.rndSection(duration[i], 300, tweenLimit);
            var btemptween = game.add.tween(this.balls[i].cameraOffset).to({ x: 10 + bSectionDistance }, section[0], Phaser.Easing.Linear.None);
            var ptemptween = game.add.tween(this.players[i]).to({ x: pSectionDistance }, section[0], Phaser.Easing.Linear.None);
            for (tweenI = 1; tweenI < tweenLimit; tweenI++) {
                btemptween.to({ x: 10 + bSectionDistance * (tweenI + 1) }, section[tweenI], Phaser.Easing.Linear.None);
                ptemptween.to({ x: pSectionDistance * (tweenI + 1) }, section[tweenI], Phaser.Easing.Linear.None);
            }
            btween[i] = btemptween;
            ptween[i] = ptemptween;
        }
        for (i = 0; i < 5; i++) {
            this.players[i].animations.add('swim', Phaser.Animation.generateFrameNames('greenJellyfish', 0, 39, '', 4), 30, true);
            this.players[i].animations.play('swim');
            btween[i].start();
            ptween[i].start();
        }
        game.add.tween(game.camera).to({ x: 720 }, cameraMoveTime, Phaser.Easing.Linear.None, true);
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
