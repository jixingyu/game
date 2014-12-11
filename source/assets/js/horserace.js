(function(){
  'use strict';
  var game, player, cursors, bg1, bg2, scoreText, enemies, backgrounds, platforms, score, worldVelocity, death, rndRange, generateBackgrounds, generatePlayer, generateEnemies, killEnemies;
  game = new Phaser.Game(1200, 480, Phaser.AUTO, '', {
    preload: preload,
    create: create,
    update: update
  });
  function preload(){
    game.load.image('background', '../../../phaser/examples/assets/misc/starfield.jpg');
    game.load.image('star', '../../../phaser/examples/assets/sprites/ufo.png');
    game.load.image('player', '../../../phaser/examples/assets/sprites/phaser-dude.png');
    return game.load.image('ground', '../../../phaser/examples/assets/steel-32.png');
  }
  score = 0;
  worldVelocity = -200;
  death = false;
  function create(){
    var i$, i, ground;
    backgrounds = game.add.group();
    generateBackgrounds();
    platforms = game.add.group();
    for (i$ = 0; i$ < 40; ++i$) {
      i = i$;
      ground = platforms.create(i * 32, 448, 'ground', 4);
      ground.body.immovable = true;
      platforms.add(ground);
    }
    enemies = game.add.group();
    setInterval(generateEnemies, 1500);
    generatePlayer();
    cursors = game.input.keyboard.createCursorKeys();
    return scoreText = game.add.text(16, 16, 'Avoided: 0', {
      fontSize: '32px',
      fill: '#fff'
    });
  }
  function update(){
    if (death === false) {
      game.physics.collide(player, platforms, '', null, this);
      game.physics.overlap(player, enemies, killEnemies, null, this);
      player.body.velocity.setTo(0, 0);
      if (cursors.up.isDown) {
        player.body.velocity.y = -300;
      } else if (cursors.down.isDown) {
        player.body.velocity.y = 300;
      }
      scoreText.content = "Avoided: " + score;
      enemies.forEach(function(enemy){
        if (enemy.x < -20) {
          if (enemy.alive === true) {
            score += 1;
            enemy.kill();
            return worldVelocity = worldVelocity - 0.5;
          }
        } else {
          return enemy.rotation += 0.02 * enemy.body.velocity.x / 25;
        }
      });
      if (bg1.x <= -1536) {
        bg1.x = bg2.x + 1536;
      }
      if (bg2.x <= -1536) {
        bg2.x = bg1.x + 1536;
      }
      return backgrounds.forEach(function(bg){
        return bg.body.velocity.x = worldVelocity;
      });
    } else {
      return scoreText.content = "You died. Reload to try again.";
    }
  }
  rndRange = function(min, max){
    var rndValue, range;
    rndValue = Math.floor(Math.random() * (max - min));
    return range = min + rndValue;
  };
  generateBackgrounds = function(){
    bg1 = game.add.tileSprite(0, 0, 1536, 512, 'background');
    bg2 = game.add.tileSprite(1536, 0, 1536, 512, 'background');
    backgrounds.add(bg1);
    return backgrounds.add(bg2);
  };
  generatePlayer = function(){
    player = game.add.sprite(150, game.world.centerY, 'player');
    return player.body.collideWorldBounds = true;
  };
  generateEnemies = function(){
    var randomAmount, i$, i, x, y, scale, enemy, results$ = [];
    randomAmount = Math.floor(rndRange(2, 4));
    for (i$ = 0; i$ < randomAmount; ++i$) {
      i = i$;
      x = game.world.width + game.world.randomX / 2;
      y = game.world.randomY;
      scale = rndRange(1, 3);
      enemy = game.add.sprite(x, y, 'star');
      enemy.body.velocity.x = worldVelocity;
      enemy.anchor.setTo(0.5, 0.5);
      results$.push(enemies.add(enemy));
    }
    return results$;
  };
  killEnemies = function(player, enemy){
    death = true;
    player.rotation = Math.PI * 0.5;
    player.scale.x = 0.5;
    worldVelocity = 0;
    return enemies.forEach(function(enemy){
      enemy.rotation = 0;
      return enemy.body.velocity.x = 0;
    });
  };
}).call(this);