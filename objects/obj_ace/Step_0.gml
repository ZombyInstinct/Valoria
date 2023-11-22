//directional movement, 0 or 1
if (canMoveRight)
	rightKey = keyboard_check(ord("D"));
if (canMoveLeft)
	leftKey = keyboard_check(ord("A"));
if (canCrouch)
	crouchKey = keyboard_check(ord("S"));

//jump is set to 0
jumpKey = 0;
if (can_jump == 1) //can only jump when you are able to
	jumpKey = keyboard_check(ord("W"));//the jump input is captured


//calculates directional input in the axis
var _xinput = rightKey - leftKey;
var _yinput = has_gravity - jump //jump with gravity

if (_xinput != 0)
{
	sprite_index = spr_ace_walking
	image_speed = 1 * global.x_moveSpeed/2;
}
else 
{
	image_speed = 0;
}

//apply gravity
if (has_gravity == 1)
{
	global.y_moveSpeed = player_gravity;
}

//movement input and avoid obj
move_and_collide(_xinput * global.x_moveSpeed, _yinput * global.y_moveSpeed, obj_grass_floor);


//ground check
if (place_meeting(x, y+1, obj_grass_floor))
{
	can_jump = 1;	//jump check is true
	has_gravity = 0; //gravity is off when on ground
}
else
{
	if (jump != 1)
	{
		has_gravity = 1 //gravity is enabled otherwise
		can_jump = 0; //and disable jumping
	}
}

//jump
if (jumpKey)
{
	jump = 1; //if the input is 1, the jump value is changed
	can_jump = 0; //prevent multi-jumping
	jumpTimer = jumpHoldFrames; //sets jump timer
	
}

//jump length
if (jumpTimer > 0)
{
	global.y_moveSpeed = jumpSpeed; //changes movement speed;
	jumpTimer--; //decreases timer
}

if (jumpTimer == 0 && can_jump == 0)
{
	has_gravity = 1; //once timer is zero, gravity returns
	jump = 0; // and jump input is removed
}

//border detection on the left side
if (place_meeting(x-2, y, obj_border))
{
	canMoveLeft = false;
	leftKey = 0;
}
else
{
	canMoveLeft = true;
}

//border detection on the right side, prevents 'sticking'
if (place_meeting(x+2, y, obj_border))
{
	canMoveRight = false;
	rightKey = 0;
}
else
{
	canMoveRight = true;
}

//border detection on the left side, prevents 'sticking'
if (!canMoveLeft)
{
	x += 3;
}
if (!canMoveRight)
{
	x -= 3;
}

//picks up passive card
if (distance_to_object(obj_passive_card) < 2) 
{
	var nearestCard = instance_nearest(x, y, obj_passive_card)
	with (nearestCard) {
		event_user(0);
	}
}

if (_xinput < 0)
{
	image_xscale = -1;
}
else if (_xinput > 0)
{
	image_xscale = 1;
}
else
{
	sprite_index = spr_Ace;
}

if (health <= 0)
{
	health = 0;
}