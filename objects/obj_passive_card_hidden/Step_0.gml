if (place_meeting(x,y,obj_ace) && !first_contact)
{
		second_visit = false;
}


curvePos += curveSpeed;

curvePos = curvePos mod 1;

var _curveStruct = animcurve_get(curveAsset);
var _channel = animcurve_get_channel(_curveStruct, "y");

var _value = animcurve_channel_evaluate(_channel, curvePos);

y = y + _value;

if (second_visit)
{
	persistent = true;
}
else persistent = false;