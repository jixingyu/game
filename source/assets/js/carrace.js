var game = new Phaser.Game(720, 1280, Phaser.AUTO, 'game');

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
        // this.load.image('lottery','assets/turntable/start-button.png');


        // this.load.audio('hit_ground_sound', 'assets/turntable/ouch.wav');

    },

    create: function () {
        this.preloadBar.cropEnabled = false;
        this.state.start('MainMenu');
    },
};


rank1=8;
rankPoints1=1*chip;
rank2 = rank3 = 0;

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

    startGame: function () {

        //  Ok, the Play Button has been clicked or touched, so let's stop the music (otherwise it'll carry on playing)
        // this.music.stop();
        myChips = {};
        if (rank1) {
            myChips.rank1 = rank1;
            myChips.rankPoints1 = rankPoints1;
        }
        if (rank2) {
            myChips.rank2 = rank2;
            myChips.rankPoints2 = rankPoints2;
        }
        if (rank3) {
            myChips.rank3 = rank3;
            myChips.rankPoints3 = rankPoints3;
        }
        var _self = this;
        ajax({
            url: '/carrace/start',
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
        for (i = 0; i < 8; i++) {
            id = this.ranklist[i];
            console.log(id);
        }
    },

    update: function () {

        //  Honestly, just about anything could go here. It's YOUR game after all. Eat your heart out!

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
