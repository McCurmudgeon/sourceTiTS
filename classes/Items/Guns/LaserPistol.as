﻿package classes.Items.Guns
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	
	public class LaserPistol extends ItemSlotClass
	{
		//constructor
		public function LaserPistol()
		{
			this._latestVersion = 1;

			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.RANGED_WEAPON;
			
			//Used on inventory buttons
			this.shortName = "LaserPistol";
			
			//Regular name
			this.longName = "mark III laser pistol";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a mark III laser pistol";
			
			//Displayed on tooltips during mouseovers
			this.tooltip = "The mark III laser pistol carries many refinements over previous models that make it far less likely to explode than its predecessors. It's the perfect weapon for a tech specialist to start with.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "shoot";
			
			//Information
			this.basePrice = 1050;
			this.attack = 2;
			this.damage = 6;
			this.damageType = GLOBAL.LASER;
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 1;
			this.evasion = 0;
			this.fortification = 0;
			this.bonusResistances = new Array(0, 0, 0, 0, 0, 0, 0, 0);
			
			this.version = _latestVersion;
		}
	}
}