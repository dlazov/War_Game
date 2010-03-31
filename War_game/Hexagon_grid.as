package War_game
{
	import flash.ui.KeyLocation;
	import War_game.Location;
	import Math;
	
	public class Hexagon_grid implements IHexagon_grid
	{
		public var grid:Array;
		private var sizeX:int;
		private var sizeY:int;
		
		public function Hexagon_grid(_sizeX:int, _sizeY:int):void
		{
			sizeX = _sizeX;
			sizeY = _sizeY;
			grid = new Array(sizeX);
			
			for (var x:int = 0; x < sizeX; x++)
			{
				grid[x] = new Array(sizeY);
			}
		}
		
		public function foreach(f:Function):void 
		{
			for (var x:int = 0; x < sizeX; x++)
			{
				for (var y:int = 0; y < sizeY; y++)
				{
					f(new Location(x,y));
				}
			}
		}
		
		/**
		* Returns an array of locations for a circle.
		*/
		public function get_circle(location:Location, r:int):Array 
		{
			var startY:int = location.y - r;
			
			var startX:int;
			var endX:int;
			if (startY % 2 == 0)
			{
				startX = location.x - Math.floor(r / 2);
				endX = location.x + r;
			}
			else
			{
				startX = location.x - Math.floor(r / 2);
				endX = location.x + r;
				if (r % 2 == 0)
				{
					startX++; endX++;
				}
				
			}	
			
			
			var endY:int = location.y + r;
			var circle_width:int = 2 * r + 1;
			var delta_y_odd:int = -1;
			var delta_y_even:int = -1;
			var offset:int = 0;
			var circle:Array = new Array();
			for (var y:int = startY; y <= endY; y++)
			{
				
				var length:int = circle_width - Math.abs(y - location.y);
				
				if (y % 2 == 0)
				{
					if (delta_y_even == -1)
						delta_y_even = Math.abs(y - location.y);
					
					offset = (Math.abs(y - location.y) - delta_y_even) / 2;
					
					if ((location.y - r) % 2 != 0)
						offset--;
				}
				else
				{
					if (delta_y_odd == -1)
						delta_y_odd = Math.abs(y - location.y);
					
					offset =  Math.floor((Math.abs(y - location.y) - delta_y_odd) / 2) - 1;
					
				}
				
				
					
				
				var start:int = startX + offset;
				//trace("y = " + y + "location = " + location.y + " : " + length);
				
				
				var s:String = "";
				for (var x:int = start; x < start + length; x++)
				{
					s += x + " ";
					if (0 <= x && x < sizeX)
						if (0 <= y && y < sizeY)
						{
							circle.push(new Location(x,y));
						}
				}	
				//trace(s);
			}
			return circle;
		}
	}	
}