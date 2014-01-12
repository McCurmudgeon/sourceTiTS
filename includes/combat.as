﻿import classes.Creature;

//Tracks what NPC in combat we are on. 0 = PC, 1 = first NPC, 2 = second NPC, 3 = fourth NPC... totalNPCs + 1 = status tic


function inCombat():Boolean 
{
	return (pc.hasStatusEffect("Round"));
}

function combatMainMenu():void 
{
	clearOutput();
	//Track round, expires on combat exit.
	if(!pc.hasStatusEffect("Round")) pc.createStatusEffect("Round",1,0,0,0,true,"","",true,0);
	else pc.addStatusValue("Round",1,1);
	//Show what you're up against.
	if(foes[0] == celise) this.userInterface.showBust("CELISE");

	for(var x:int = 0; x < foes.length; x++) {
		if(x > 0) output("\n\n");
		displayMonsterStatus(foes[x]);
	}
	//Check to see if combat should be over or not.
	//Victory check first, because PC's are OP.
	if(allFoesDefeated()) {
		//new PG for start of victory text, overrides normal menus.
		output("\n");
		//Route to victory menus and GTFO.		
		//userInterface.clearMenu();
		//userInterface.addButton(0,"Victory",victoryRouting);
		victoryRouting();
		return;
	}
	else if(pc.HP() <= 0 || pc.lust() >= 100 || ((pc.physique() == 0 || pc.willpower() == 0) && pc.hasStatusEffect("Naleen Venom") && foes[0] is Naleen)) {
		//YOU LOSE! GOOD DAY SIR!
		trace("DEFEAT LOSS! - IN MAIN MENU");
		output("\n");
		//userInterface.clearMenu();
		//userInterface.addButton(0,"Defeat",defeatRouting);
		defeatRouting();
		return;
	}
	//Tutorial menus
	if(foes[0].short == "Celise") {
		celiseMenu();
		return;
	}
	updateCombatStatuses();
	
	//Stunned Menu
	if (pc.hasStatusEffect("Stunned") || pc.hasStatusEffect("Paralyzed"))
	{
		if(pc.hasStatusEffect("Stunned")) output("\n<b>You're still stunned!</b>");
		this.userInterface.addButton(0,"Recover",stunRecover);
	}
	//Bound Menu
	else if (pc.hasStatusEffect("Naleen Coiled"))
	{
		output("\n<b>You are wrapped up in coils!</b>");
		userInterface.addButton(0,"Struggle",naleenStruggle);
		this.userInterface.addButton(4,"Do Nothing",wait);
	}
	else 
	{
		//Combat menu
		this.userInterface.clearMenu();
		this.userInterface.addButton(0,"Attack",attackRouter,playerAttack);
		this.userInterface.addButton(1,upperCase(pc.rangedWeapon.attackVerb),attackRouter,playerRangedAttack);
		this.userInterface.addButton(4,"Do Nothing",wait);
		this.userInterface.addButton(5,"Tease",attackRouter,tease);
		this.userInterface.addButton(6,"Fantasize",fantasize);
		this.userInterface.addButton(14,"Run",runAway);

	}
}
function updateCombatStatuses():void {
	if(pc.hasStatusEffect("Blind")) {
		pc.addStatusValue("Blind",1,-1);
		if(pc.statusEffectv1("Blind") <= 0) {
			pc.removeStatusEffect("Blind");
			output("<b>You can see again!</b>\n");
		}
	}
	if(pc.hasStatusEffect("Paralyzed")) {
		pc.addStatusValue("Paralyzed",1,-1);
		if(pc.statusEffectv1("Paralyzed") <= 0) {
			pc.removeStatusEffect("Paralyzed");
			output("<b>The paralytic venom wears off, and you are able to move once more.</b>\n");
		}
		else output("<b>You're paralyzed and unable to move!</b>\n");
	}
}
function stunRecover():void 
{
	if(pc.hasStatusEffect("Stunned")) {
		clearOutput();
		pc.addStatusValue("Stunned",1,-1);
		if (pc.statusEffectv1("Stunned") <= 0)
		{
			pc.removeStatusEffect("Stunned");
			output("You manage to recover your wits and adopt a fighting stance!\n");
		}
		else
			output("You're still too stunned to act!\n");
	}
	if(pc.hasStatusEffect("Paralyzed")) {
		clearOutput();
		if(pc.statusEffectv1("Paralyzed") <= 1) output("The venom seems to be weakening, but you can't move yet!\n");
		else output("You try to move, but just can't manage it!\n");
	}
	processCombat();
}
function celiseMenu():void 
{
	this.userInterface.clearMenu();
	if(pc.statusEffectv1("Round") == 1) 
		this.userInterface.addButton(0,"Attack",attackRouter,playerAttack);
	else if(pc.statusEffectv1("Round") == 2) 
		this.userInterface.addButton(1,upperCase(pc.rangedWeapon.attackVerb),attackRouter,playerRangedAttack);
	else 
		this.userInterface.addButton(5,"Tease",attackRouter,tease);
}

function processCombat():void 
{
	combatStage++;
	trace("COMBAT STAGE:" + combatStage);
	//Check to see if combat should be over or not.
	//Victory check first, because PC's are OP.
	if(allFoesDefeated()) {
		//Go back to main menu for victory announcement.
		this.userInterface.clearMenu();
		this.userInterface.addButton(0,"Victory",combatMainMenu);
		return;
	}
	if (pc.HP() <= 0 || pc.lust() >= 100 || ((pc.physique() <= 0 || pc.willpower() <= 0) && pc.hasStatusEffect("Naleen Venom") && foes[0] is Naleen))
	{
		trace("DEFEAT LOSS!");
		trace("PHYS: " + pc.physique() + " WILLPOWAH:" + pc.willpower());
		if(pc.hasStatusEffect("NALEEN VENOM")) trace("VENOMED");
		if(foes[0] is Naleen) trace("FIGHTIN NALEEN");

		//YOU LOSE! GOOD DAY SIR!
		this.userInterface.clearMenu();
		this.userInterface.addButton(0,"Defeat",combatMainMenu);
		return;
	}
	//If enemies still remain, do their AI routine.
	if(combatStage-1 < foes.length) {
		output("\n");
		enemyAI(foes[combatStage-1]);
		return;
	}
	combatStage = 0;
	this.userInterface.clearMenu();
	this.userInterface.addButton(0,"Next",combatMainMenu);
}

function allFoesDefeated():Boolean 
{
	for(var x:int = 0; x < foes.length; x++) {
		//If a foe is up, fail.
		if(foes[x].HP() > 0 && foes[x].lust() < 100) return false;
	}
	//If we get through them all, check! All foes down.
	return true;
}

function combatMiss(attacker:Creature, target:Creature):Boolean 
{
	if(rand(100) + attacker.physique()/5 + attacker.meleeWeapon.attack - target.reflexes()/5 < 10 && !target.isImmobilized()) 
	{
		return true;
	}
	if(target.hasPerk("Melee Immune")) return true;
	return false;
}
function rangedCombatMiss(attacker:Creature, target:Creature):Boolean 
{
	if(rand(100) + attacker.aim()/5 + attacker.rangedWeapon.attack - target.reflexes()/5 < 10 && !target.isImmobilized()) 
	{
		return true;
	}
	if(target.hasPerk("Ranged Immune")) return true;
	return false;
}

function attackRouter(destinationFunc):void 
{
	clearOutput();
	output("Who do you target?\n");
	for(var x:int = 0; x < foes.length; x++) {
		output(foes[x].capitalA + foes[x].short + ": " + foes[x].HP() + " HP, " + foes[x].lust() + " Lust\n");
	}
	var button:int = 0;
	var counter:int = 0;
	if(foes.length == 1) {
		destinationFunc(foes[0]);
		return;
	}
	this.userInterface.clearMenu();
	while(counter < foes.length) {
		this.userInterface.addButton(button,foes[0].short,destinationFunc,foes[counter]);
		counter++;
		button++;
	}
	if(button < 14) button = 14;
	this.userInterface.addButton(button,"Back",combatMainMenu);
}

// Really?
function enemyAttack(attacker:Creature):void 
{
	attack(attacker, pc);
}
function playerAttack(target:Creature):void 
{
	attack(pc, target);
}
function playerRangedAttack(target:Creature):void 
{
	rangedAttack(pc, target);
}

function attack(attacker:Creature, target:Creature, noProcess:Boolean = false, special:int = 0):void {
	if(foes[0].short == "female zil") flags["HIT_A_ZILGIRL"] = 1;
	if(!attacker.hasStatusEffect("Multiple Attacks") && attacker == pc) clearOutput();
	//Run with multiple attacks!
	if (attacker.hasPerk("Multiple Attacks")) {
		//Start up
		if (!attacker.hasStatusEffect("Multiple Attacks")) 
		{
			attacker.createStatusEffect("Multiple Attacks",attacker.perkv1("Multiple Attacks"),0,0,0,true,"","",true,0);		
		}
		//Remove if last attack, otherwise decrement.
		else 
		{
			if(attacker.statusEffectv1("Multiple Attacks") <= 0) attacker.removeStatusEffect("Multiple Attacks");
			attacker.addStatusValue("Multiple Attacks",1,-1);
		}
	}
	//Attack missed!
	if(combatMiss(attacker,target)) {
		if(target.customDodge == "") {
			if(attacker == pc) output("You " + pc.meleeWeapon.attackVerb + " at " + target.a + target.short + " with your " + pc.meleeWeapon.longName + ", but just can't connect.");
			else output("You manage to avoid " + attacker.a + possessive(attacker.short) + " " + attacker.meleeWeapon.attackVerb + ".");
		}
		else output(target.customDodge);
	}
	//Extra miss for blind
	else if(attacker.hasStatusEffect("Blind") && rand(2) > 0) {
		if(attacker == pc) output("Your blind strike fails to connect.");
		else output(attacker.capitalA + possessive(attacker.short) + " blind " + attacker.meleeWeapon.attackVerb + " goes wide!");
	}
	//Additional Miss chances for if target isn't stunned and this is a special flurry attack (special == 1)
	else if(special == 1 && rand(100) <= 45 && !target.isImmobilized()) {
		if(target.customDodge == "") {
			if(attacker == pc) output("You " + pc.meleeWeapon.attackVerb + " at " + target.a + target.short + " with your " + pc.meleeWeapon.longName + ", but just can't connect.");
			else output("You manage to avoid " + attacker.a + possessive(attacker.short) + " " + attacker.meleeWeapon.attackVerb + ".");
		}
		else output(target.customDodge);
	}
	//Celise autoblocks
	else if(target.short == "Celise") {
		output(target.customBlock);
	}
	//Attack connected!
	else {
		if(attacker == pc) output("You land a hit on " + target.a + target.short + " with your " + pc.meleeWeapon.longName + "!");
		else if(!attacker.plural) output(attacker.capitalA + attacker.short + " connects with " + attacker.mfn("his","her","its") + " " + attacker.meleeWeapon.longName + "!");
		else output(attacker.capitalA + attacker.short + " connect with their " + attacker.meleeWeapon.longName + "!");
		//Damage bonuses:
		var damage:int = attacker.meleeWeapon.damage + attacker.physique()/2;
		//Randomize +/- 15%
		var randomizer = (rand(31)+ 85)/100;
		damage *= randomizer;
		var sDamage:Array = new Array();
		//Apply damage reductions
		if(target.shieldsRaw > 0) {
			sDamage = shieldDamage(target,damage,attacker.meleeWeapon.damageType);
			//Set damage to leftoverDamage from shieldDamage
			damage = sDamage[1];
			if(attacker == pc) {
				if(target.shieldsRaw > 0) output(" The shield around " + target.a + target.short + " crackles under your assault, but it somehow holds. (<b>" + sDamage[0] + "</b>)");
				else output(" There is a concussive boom and tingling aftershock of energy as you disperse " + target.a + possessive(target.short) + " defenses. (<b>" + sDamage[0] + "</b>)");
			}
			else {
				if(target.shieldsRaw > 0) output(" Your shield crackles but holds. (<b>" + sDamage[0] + "</b>)");
				else output(" There is a concussive boom and tingling aftershock of energy as your shield is breached. (<b>" + sDamage[0] + "</b>)");
			}
		}
		if(damage >= 1) {
			damage = HPDamage(target,damage,attacker.meleeWeapon.damageType);
			if(attacker == pc) {
				if(sDamage[0] > 0) output(" Your " + attacker.meleeWeapon.damageType + " has enough momentum to carry through and strike your target! (<b>" + damage + "</b>)");
				else output(" (<b>" + damage + "</b>)");			
			}
			else {
				if(sDamage[0] > 0) output(" The hit carries on through to damage you! (<b>" + damage + "</b>)");
				else output(" (<b>" + damage + "</b>)");	
			}
		}
	}
	//Do multiple attacks if more are queued (does not stack with special!)
	if(attacker.hasStatusEffect("Multiple Attacks") && special == 0) {
		output("\n");
		attack(attacker,target);
		return;
	}
	output("\n");
	if(!noProcess) processCombat();
}

function rangedAttack(attacker:Creature, target:Creature, noProcess:Boolean = false, special:int = 0):void 
{
	trace("Ranged shot...");
	if(!attacker.hasStatusEffect("Multiple Shots") && attacker == pc) clearOutput();
	//Run with multiple attacks!
	if (attacker.hasPerk("Multiple Shots")) {
		//Start up
		if (!attacker.hasStatusEffect("Multiple Shots")) 
		{
			attacker.createStatusEffect("Multiple Shots",attacker.perkv1("Multiple Shots"),0,0,0,true,"","",true,0);		
		}
		//Remove if last attack, otherwise decrement.
		else 
		{
			if(attacker.statusEffectv1("Multiple Shots") <= 0) attacker.removeStatusEffect("Multiple Shots");
			attacker.addStatusValue("Multiple Shots",1,-1);
		}
	}
	//Attack missed!
	//Blind prevents normal dodginess & makes your attacks miss 90% of the time.
	if(rangedCombatMiss(attacker,target)) {
		if(target.customDodge == "") {
			if(attacker == pc) output("You " + pc.rangedWeapon.attackVerb + " at " + target.a + target.short + " with your " + pc.rangedWeapon.longName + ", but just can't connect.");
			else output("You manage to avoid " + attacker.a + possessive(attacker.short) + " " + attacker.rangedWeapon.attackVerb + ".");
		}
		else output(target.customDodge)
	}
	//Extra miss for blind
	else if(attacker.hasStatusEffect("Blind") && rand(10) > 0) {
		if(attacker == pc) output("None of your blind-fired shots manage to connect.");
		else output(attacker.capitalA + possessive(attacker.short) + " blinded shots fail to connect!");
	}
	//Additional Miss chances for if target isn't stunned and this is a special flurry attack (special == 1)
	else if(special == 1 && rand(100) <= 45 && !target.isImmobilized()) {
		if(target.customDodge == "") {
			if(attacker == pc) output("You " + pc.rangedWeapon.attackVerb + " at " + target.a + target.short + " with your " + pc.rangedWeapon.longName + ", but just can't connect.");
			else output("You manage to avoid " + attacker.a + possessive(attacker.short) + " " + attacker.rangedWeapon.attackVerb + ".");
		}
		else output(target.customDodge);
	}
	//Celise autoblocks
	else if(target.short == "Celise") {
		output("Celise takes the hit, wound instantly closing in with fresh, green goop. Her surface remains perfectly smooth and unmarred after.");
	}
	//Attack connected!
	else {
		if(attacker == pc) output("You land a hit on " + target.a + target.short + " with your " + pc.rangedWeapon.longName + "!");
		else output(attacker.capitalA + attacker.short + " connects with " + attacker.mfn("his","her","its") + " " + attacker.rangedWeapon.longName + "!");
		//Damage bonuses:
		var damage:int = attacker.rangedWeapon.damage + attacker.aim()/2;
		//Randomize +/- 15%
		var randomizer = (rand(31)+ 85)/100;
		damage *= randomizer;
		var sDamage:Array = new Array();
		//Apply damage reductions
		if(target.shieldsRaw > 0) {
			sDamage = shieldDamage(target,damage,attacker.meleeWeapon.damageType);
			//Set damage to leftoverDamage from shieldDamage
			damage = sDamage[1];
			if(attacker == pc) {
				if(target.shieldsRaw > 0) output(" The shield around " + target.a + target.short + " crackles under your assault, but it somehow holds. (<b>" + sDamage[0] + "</b>)");
				else output(" There is a concussive boom and tingling aftershock of energy as you disperse " + target.a + possessive(target.short) + " defenses. (<b>" + sDamage[0] + "</b>)");
			}
			else {
				if(target.shieldsRaw > 0) output(" Your shield cracles but holds. (<b>" + sDamage[0] + "</b>)");
				else output(" There is a concussive boom and tingling aftershock of energy as your shield is breached. (<b>" + sDamage[0] + "</b>)");
			}
		}
		if(damage >= 1) {
			damage = HPDamage(target,damage,attacker.rangedWeapon.damageType);
			if(attacker == pc) {
				if(sDamage[0] > 0) output(" Your " + attacker.rangedWeapon.damageType + " has enough momentum to carry through and strike your target! (<b>" + damage + "</b>)");
				else output(" (<b>" + damage + "</b>)");			
			}
			else {
				if(sDamage[0] > 0) output(" The hit carries on through to hit you! (<b>" + damage + "</b>)");
				else output(" (<b>" + damage + "</b>)");	
			}
		}
	}
	//Do multiple attacks if more are queued.
	if(attacker.hasStatusEffect("Multiple Shots")) {
		output("\n");
		rangedAttack(attacker,target);
		return;
	}
	output("\n");
	if(!noProcess) processCombat();
}

function genericDamageApply(damage:int,attacker:Creature, target:Creature):void {
	//Randomize +/- 15%
	var randomizer = (rand(31)+ 85)/100;
	damage *= randomizer;
	var sDamage:Array = new Array();
	//Apply damage reductions
	if (target.shieldsRaw > 0) {
		sDamage = shieldDamage(target,damage,attacker.meleeWeapon.damageType);
		//Set damage to leftoverDamage from shieldDamage
		damage = sDamage[1];
		if (target.shieldsRaw > 0) 
			output(" Your shield crackles but holds. (<b>" + sDamage[0] + "</b>)");
		else 
			output(" There is a concussive boom and tingling aftershock of energy as your shield is breached. (<b>" + sDamage[0] + "</b>)");
	}
	if(damage >= 1) 
	{
		damage = HPDamage(target,damage,attacker.meleeWeapon.damageType);
		if (sDamage[0] > 0) 
			output(" The attack continues on to connect with you! (<b>" + damage + "</b>)");
		else 
			output(" (<b>" + damage + "</b>)");
	}
}


function HPDamage(victim:Creature,damage:Number = 0, damageType = GLOBAL.KINETIC):Number 
{
	//Reduce damage by defense value
	damage -= victim.defense();
	
	//Apply type reductions!
	damage *= victim.getResistance(damageType);
	//None yet!
	
	damage = Math.round(damage);
	
	//Damage cannot exceed HP amount.
	if(damage > victim.HP()) {
		damage = victim.HP();
	}
	//If we're this far, damage can't be less than one. You did get hit, after all.
	if(damage < 1) damage = 1;
	//Apply the damage
	victim.HP(-1 * damage);
	//Pass back how much was done.
	return damage;
}

function shieldDamage(victim:Creature,damage:Number = 0, damageType = GLOBAL.KINETIC):Array 
{
	var initialDamage:Number = damage;
	var soakedDamage:Number = 0;
	var leftoverDamage:int = 0;
	//Reduce damage by shield defense value
	damage -= victim.shieldDefense();
	
	//Apply victim resistances vs damage
	damage *= victim.getShieldResistance(damageType);

	//Debug trace statements to help me doublecheck that all this is working right
	//trace("INITIAL DAMAGE: " + initialDamage);
	//trace("SHIELD DEFENSE VALUE: " + victim.shieldDefense());	
	//trace("SHIELD DAMAGE MULTIPLIER: " + victim.getShieldResistance(damageType));
	
	damage = Math.round(damage);
	
	//Damage cannot exceed shield amount.
	if(damage > victim.shieldsRaw) {
		damage = victim.shieldsRaw;
		soakedDamage = (damage - victim.shieldDefense()) / victim.getShieldResistance(damageType);
		leftoverDamage = initialDamage - soakedDamage;
		//If shit rounded up, that might put leftover damage in negs.
		//Prevent dat.
		if(leftoverDamage < 0) leftoverDamage = 0;
		
		//Second half of checking shield stuff.
		//trace("Damage soaked up by shields: " + soakedDamage);
		//trace("New leftover damage: " + leftoverDamage);
	}
	//If we're this far, damage can't be less than one. You did get hit, after all.
	if(damage < 1) damage = 1;
	//Apply the damage
	victim.shieldsRaw -= damage;
	//Pass back how much was done and how much is leftover.
	return [damage,leftoverDamage];
}

function tease(target:Creature):void 
{
	clearOutput();
	if(target is Celise) {
		output("You put a hand on your hips and lewdly expose your groin, wiggling to and fro in front of the captivated goo-girl.\n");
	}
	else {
		output("You do your best to look sexy, but it doesn't work THAT well because this is a total placeholder! (10)");
		output("\n");
		target.lust(10);
	}
	processCombat();
}

//Name, long descript, lust descript, and '"
function displayMonsterStatus(targetFoe):void 
{
	if(targetFoe.HP() <= 0) {
		output("<b>You've knocked the resistance out of " + targetFoe.a + targetFoe.short + ".</b>\n");
	}
	else if(targetFoe.lust() >= 100) {
		output("<b>" + targetFoe.capitalA + targetFoe.short + " </b>");
		if(targetFoe.plural) output("<b>are </b>");
		else output("<b>is </b>");
		output("<b>too turned on to fight.</b>\n");
	}
	else if(pc.lust() >= 100 || pc.HP() <= 0) {
		if(pc.HP() <= 0) {
			if(foes[0].plural || foes.length > 1) output("<b>Your enemies have knocked you off your " + pc.feet() + "!</b>\n");
			else output("<b>" + targetFoe.capitalA + targetFoe.short + " has knocked you off your " + pc.feet() + "!</b>\n");
		}
		else if(foes.length > 1 || foes[0].plural) output("<b>" + targetFoe.capitalA + targetFoe.short + " have turned you on too much to keep fighting. You give in....</b>\n");
		else output("<b>" + targetFoe.capitalA + targetFoe.short + " has turned you on too much to keep fighting. You give in....</b>\n");
	}
	else {
		if(pc.statusEffectv1("Blind") <= 1) {
			output("<b>You're fighting " + targetFoe.a + targetFoe.short  + ".</b>\n" + targetFoe.long + "\n");
			showMonsterArousalFlavor(targetFoe);
		}
		else {
			output("<b>You're too blind to see your foe!</b>\n");
		}
	}
	//Celise intro specials.
	if(targetFoe is Celise) {
		//Round specific dad addons!
		if(pc.statusEffectv1("Round") == 1) output("\nVictor instructs, <i>“<b>Try and strike her, " + pc.short + ". Use a melee attack.</b>”</i>\n");
		else if(pc.statusEffectv1("Round") == 2) output("\n<i>“Some foes are more vulnerable to ranged attacks than melee attacks or vice versa. <b>Why don’t you try using your gun?</b> Don’t worry, it won’t kill her.”</i> Victor suggests.\n");
		else if(pc.statusEffectv1("Round") == 3) output("\n<i>“Didn’t work, did it? Celise’s race does pretty well against kinetic damage. Thermal weapons would work, but you don’t have any of those. You’ve still got one more weapon that galotians can’t handle - sexual allure. They’re something of a sexual predator, but their libidos are so high that teasing them back often turns them on to the point where they masturbate into a puddle of quivering sex.”</i>  Victor chuckles. <i>“<b>Go ahead, try teasing her.</b> Fighting aliens is about using the right types of attacks in the right situations.”</i>\n");
	}
}

function showMonsterArousalFlavor(targetFoe):void 
{
	if(targetFoe.lust() < 50) { 
		return; 
	}
	else if(targetFoe.plural) {
		if(targetFoe.lust() < 60) output(targetFoe.capitalA + possessive(targetFoe.short) + " skins remain flushed with the beginnings of arousal.");
		else if(targetFoe.lust() < 70) output(targetFoe.capitalA + possessive(targetFoe.short) + " eyes constantly dart over your most sexual parts, betraying their lust.");
		else if(targetFoe.lust() < 85) {
			if(targetFoe.hasCock()) output(targetFoe.capitalA + targetFoe.short + " are having trouble moving due to the rigid protrusions in their groins.");
			if(targetFoe.hasVagina()) output(targetFoe.capitalA + targetFoe.short + " are obviously turned on; you can smell their arousal in the air.");
		}
		else {
			if(targetFoe.hasCock()) output(targetFoe.capitalA + targetFoe.short + " are panting and softly whining, each movement seeming to make their bulges more pronounced.  You don't think they can hold out much longer.");
			if(targetFoe.hasVagina()) output(targetFoe.capitalA + possessive(targetFoe.short) + " " + plural(targetFoe.vaginaDescript()) + " are practically soaked with their lustful secretions.");
		}
	}
	else {
		if(targetFoe.lust() < 60) output(targetFoe.capitalA + possessive(targetFoe.short) + " " + targetFoe.skin() + " remains flushed with the beginnings of arousal.");
		else if(targetFoe.lust() < 70) output(targetFoe.capitalA + possessive(targetFoe.short) + " eyes constantly dart over your most sexual parts, betraying " + targetFoe.mfn("his","her","its") + " lust.");
		else if(targetFoe.lust() < 85) {
			if(targetFoe.hasCock()) output(targetFoe.capitalA + targetFoe.short + " is having trouble moving due to the rigid protrusion in " + targetFoe.mfn("his","her","its") + " groin.");
			if(targetFoe.hasVagina()) output(targetFoe.capitalA + targetFoe.short + " is obviously turned on, you can smell " + targetFoe.mfn("his","her","its") + " arousal in the air.");
		}
		else {
			if(targetFoe.hasCock()) output(targetFoe.capitalA + targetFoe.short + " is panting and softly whining, each movement seeming to make " + targetFoe.mfn("his","her","its") + " bulge more pronounced.  You don't think " + targetFoe.mfn("he","she","it") + " can hold out much longer.");
			if(targetFoe.hasVagina()) output(targetFoe.capitalA + possessive(targetFoe.short) + " " + targetFoe.vaginaDescript() + " is practically soaked with " + targetFoe.mfn("his","her","its") + " lustful secretions.  ");
		}
	}
	output("\n");
}

function enemyAI(aggressor:Creature):void 
{	
	trace("AI CALL");
	//Foe specific AIs
	switch(foes[0].short) {
		case "Celise":
			celiseAI();
			break;
		case "two zil":
			zilpackAI();
			break;
		case "zil male":
			zilMaleAI();
			break;
		case "female zil":
			zilGirlAI();
			break;
		case "cunt snake":
			cuntSnakeAI();
			break;
		case "naleen":
			naleenAI();
			break;
		default:
			enemyAttack(aggressor);
			break;
	}
}

function victoryRouting():void 
{
	hideNPCStats();
	if(foes[0].short == "Celise") {
		defeatCelise();
	}
	else if(foes[0].short == "two zil") {
		defeatZilPair();
	}
	else if(foes[0].short == "female zil") {
		defeatHostileZil();
	}
	else if(foes[0].short == "zil male") {
		winVsZil();
	}
	else if(foes[0].short == "cunt snake") {
		defeatACuntSnake();
	}
	else if(foes[0].short == "naleen") {
		beatDatCatNaga();
	}
	else genericVictory();
}

function defeatRouting():void 
{
	hideNPCStats();
	if(foes[0].short == "BONERS") {}
	else if(foes[0].short == "two zil") {
		loseToZilPair();
	}
	else if(foes[0].short == "zil male") {
		zilLossRouter();
	}
	else if(foes[0].short == "female zil") {
		girlZilLossRouter();
	}
	else if(foes[0].short == "cunt snake") {
		loseToCuntSnake();
	}
	else if(foes[0].short == "naleen") {
		pcLosesToNaleenLiekABitch();
	}
	else {
		output("You lost!  You rouse yourself after an hour and a half, quite bloodied.");
		processTime(90);
		genericLoss();
	}
}

function genericLoss():void {
	pc.removeStatusEffect("Round");
	pc.clearCombatStatuses();
	this.userInterface.clearMenu();
	this.userInterface.addButton(0,"Next",mainGameMenu);
}

function genericVictory():void 
{
	pc.clearCombatStatuses();
	getCombatPrizes();
}

function combatOver():void 
{
	pc.removeStatusEffect("Round");
	this.userInterface.clearMenu();
	this.userInterface.addButton(0,"Next",mainGameMenu);
}


function getCombatPrizes(newScreen:Boolean = false):void 
{
	if(newScreen) clearOutput();
	
	// Renamed from lootList so I can distinguish old vs new uses
	var foundLootItems:Array = new Array();

	//Add credits and XP
	var XPBuffer:int = 0;
	var creditBuffer:int = 0;
	for(var x:int = 0; x < foes.length; x++) {
		XPBuffer = foes[x].XP();
		creditBuffer += foes[x].credits;
	}
	//If new XP + old is more than max, change XP to be the difference.
	if(XPBuffer + pc.XP() > pc.XPMax()) XPBuffer = pc.XPMax() - pc.XP();
	pc.XP(XPBuffer);
	pc.credits += creditBuffer;
	
	//Queue up items for looting
	for(var x:int = 0; x < foes.length; x++) 
	{
		for(var y:int = 0; y < foes[x].inventory.length; y++) 
		{
			
			if(foes[x].inventory[y].quantity != 0) {
				foundLootItems[foundLootItems.length] = foes[x].inventory[y]; // NOTE: Might have to come back through here and use copies; depends how shit plays out with combat + persistent characters.
				if(foes[x].inventory[y].useFunction != undefined) {
					trace("NOT UNDEFINED! X: " + x + " Y: " + y);
					if(foundLootItems[foundLootItems.length-1].useFunction == undefined) trace("SAME LOOT LIST: UNDEFINED");
					else trace("SAME LOOT LIST: CONDITION GREEN");
				}
				else trace("UNDEFINED FUNC: " + foes[x].inventory[y].longName);
			}
		}
	}
	
	//Exit combat as far as the game is concerned.
	pc.removeStatusEffect("Round");
	//Talk about who died and what you got.
	output("You defeated ");
	clearList();
	for(x = 0; x < foes.length; x++) {
		addToList(foes[x].a + foes[x].short);
	}
	output(formatList() + "!");
	if(XPBuffer > 0) output(" " + XPBuffer + " XP gained.\n");
	else output(" <b>Maximum XP attained! You need to level up to continue to progress.</b>\n")
	
	//Monies!
	if(creditBuffer > 0) {
		if(foes.length > 1 || foes[0].plural) output(" They had ");
		else output(foes[0].mfn(" He"," She", " It") + " had ");
		output(num2Text(creditBuffer) + " credit");
		if(creditBuffer > 1) output("s");
		output(" loaded on an anonymous credit chit that you appropriate.\n");
	}
	this.userInterface.clearMenu();
	//Fill wallet and GTFO
	if(foundLootItems.length > 0) {
		output("You also find ");
		clearList();
		for(x = 0; x < foundLootItems.length; x++) {
			addToList(foundLootItems[x].description + " (x" + foundLootItems[x].quantity + ")\n\n");
		}
		output(formatList());
		itemScreen = mainGameMenu;
		lootScreen = mainGameMenu;
		useItemFunction = mainGameMenu;
		//Start loot
		itemCollect(foundLootItems);
	}
	//Just leave if no items.
	else {
		this.userInterface.addButton(0,"Next",mainGameMenu);
	}
}

function startCombat(encounter:String):void 
{
	combatStage = 0;
	hideMinimap();
	userInterface.resetNPCStats();
	showNPCStats();
	pc.removeStatusEffect("Round");
	foes = new Array();
	
	// There's some room for improvement here; rather than constantly creating new instances/copies of combatable creatures, we could give them
	// some kind of setup method, and use the persistent object in the chars[] object to refer to them. The setup method would reset their health
	// and reconfigure their inventory as appropriate (allows randomised inventory for each creature, for each time you fight them; or in the case
	// of persistent creatures, wouldn't reset their inventory, or do it under some other limitation, like it only resets every so many game days etc
	
	// I'm leaving it as is for now, to avoid introducing massive changes all over the place in a single merge. Although, I'm dropping clone() and
	// using the new makeCopy() semantic.
	
	switch(encounter) {
		case "celise":
			this.userInterface.showBust("CELISE");
			setLocation("FIGHT:\nCELISE","TAVROS STATION","SYSTEM: KALAS");
			foes[0] = chars["CELISE"].makeCopy();
			break;
		case "zilpack":
			this.userInterface.showBust("ZILPACK");
			setLocation("FIGHT:\nTWO ZIL","PLANET: MHEN'GA","SYSTEM: ARA ARA");
			foes[0] = chars["ZILPACK"].makeCopy();
			break;
		case "zil male":
			this.userInterface.showBust("ZIL");
			setLocation("FIGHT:\nZIL MALE","PLANET: MHEN'GA","SYSTEM: ARA ARA");
			initializeZil();
			break;
		case "female zil":
			userInterface.showBust("ZILFEMALE");
			setLocation("FIGHT:\nFEMALE ZIL","PLANET: MHEN'GA","SYSTEM: ARA ARA");
			foes[0] = chars["ZILFEMALE"].makeCopy();
			break;
		case "cunt snake":
			this.userInterface.showBust("CUNTSNAKE");
			setLocation("FIGHT:\nCUNT SNAKE","PLANET: MHEN'GA","SYSTEM: ARA ARA");
			initializeCSnake();
			break;
		case "naleen":
			this.userInterface.showBust("NALEEN");
			setLocation("FIGHT:\nNALEEN","PLANET: MHEN'GA","SYSTEM: ARA ARA");
			foes[0] = chars["NALEEN"].makeCopy();
			break;
		default:
			throw new Error("Tried to configure combat encounter for '" + encounter + "' but couldn't find an appropriate setup method!");
			break;
	}
	combatMainMenu();
}

function runAway():void {
	clearOutput();
	output("You attempt to flee from your opponent");
	if(foes[0].plural || foes.length > 1) output("s");
	output("! ")
	//Autofail conditions first!
	if(pc.isImmobilized()) {
		output("You cannot run while you are immobilized!\n");
		processCombat();
	}
	else if(pc.hasStatusEffect("Flee Disabled")) {
		output("You cannot escape from this fight!\n");
		processCombat();
	}
	else if(debug) {
		output("You escape on wings of debug!\n");
		pc.removeStatusEffect("Round");
		pc.clearCombatStatuses();
		this.userInterface.hideNPCStats();
		this.userInterface.clearMenu();
		this.userInterface.addButton(0,"Next",mainGameMenu);
	}
	else {
		var x:int = 0;
		//determine difficulty class based on reflexes vs reflexes comparison, easy, low, medium, hard, or very hard
		var difficulty:int = 0;
		//easy = succeed 75%
		//low = succeed 50%
		//medium = succeed 35%
		//hard = succeed 20;
		//very hard = succeed 10%
		//Easy: PC has twice the reflexes
		if(pc.reflexes() >= foes[0].reflexes() * 2) difficulty = 0;
		//Low: PC has more than +33% more reflexes
		else if(pc.reflexes() >= foes[0].reflexes() * 1.333) difficulty = 1;
		//Medium: PC has more than -33% reflexes
		else if(pc.reflexes() >= foes[0].reflexes() * .6666) difficulty = 2;
		//Hard: PC pretty slow
		else if(pc.reflexes() >= foes[0].reflexes() * .3333) difficulty = 3;
		//Very hard: PC IS FUCKING SLOW
		else difficulty = 4;


		//Multiple NPCs? Raise difficulty class for each one!
		difficulty += foes.length - 1;
		if(difficulty > 5) difficulty = 5;
		//Raise difficulty for having awkwardly huge genitalia/boobs sometime! TODO!

		//Lower difficulty for flight if enemy cant!
		if(pc.canFly() && (!foes[0].canFly() || foes[0].isImmobilized())) difficulty--;
		//Lower difficulty for immobilized foe
		if(foes[0].isImmobilized()) difficulty--;

		//Set threshold value and check!
		if(difficulty < 0) difficulty = 100;
		else if(difficulty == 0) difficulty = 75;
		else if(difficulty == 1) difficulty = 50;
		else if(difficulty == 2) difficulty = 35;
		else if(difficulty == 3) difficulty = 20;
		else if(difficulty == 4) difficulty = 10;
		else difficulty = 5;
		trace("Successful escape chance: " + difficulty + " %")
		//Success!
		if(rand(100) + 1 <= difficulty) {
			if(pc.canFly()) output("Your feet leave the ground as you fly away, leaving the fight behind.")
			else output("You manage to leave the fight behind you.")
			processTime(8);
			pc.removeStatusEffect("Round");
			pc.clearCombatStatuses();
			this.userInterface.hideNPCStats(); // Putting it here is kinda weird, but seeing the enemy HP value drop to 0 also seems a bit weird too
			this.userInterface.clearMenu();
			this.userInterface.addButton(0,"Next",mainGameMenu);
		}
		else {
			output(" It doesn't work!\n");
			processCombat();
		}

	}
}
function fantasize():void {
	clearOutput();
	output("You decide you'd rather fantasize than fight back at this point. Why bother when your enem");
	if(foes[0].plural || foes.length > 1) output("ies are");
	else output("y is");
	output(" so alluring?\n");
	pc.lust(20+rand(20));
	processCombat();
}
function wait():void {
	clearOutput();
	output("You choose not to act.\n");
	processCombat();
}