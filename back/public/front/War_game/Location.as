﻿package War_game
{
	public class Location
	{
		public var x:int;
		public var y:int;
		public function Location(new_x:int=0,new_y:int=0):void 
		{
			x = new_x;
			y = new_y;
		}
		
		public static function un_pickle(s:String):Array 
		{
			var a:Array = s.split(" ");
			return a;
		}
		
		public function toString():String
		{
			return x + " " + y;
		}
	}
}