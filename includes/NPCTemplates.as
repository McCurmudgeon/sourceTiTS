﻿function initializeNPCs(justUpdate:Boolean = false):void {
	if (!justUpdate || (justUpdate && characters[GLOBAL.CELISE].short == "uncreated"))
	{
		characters[GLOBAL.CELISE] = new Creature();
		celise = characters[GLOBAL.CELISE];
		celise.short = "Celise";
		celise.originalRace = "galotian";
		celise.a = "";
		celise.capitalA = "";
		celise.long = "A three foot high, oblong ball of goo jiggles and wobbles across from you, its surface somehow holding back the liquid weight inside even though it appears no more solid than the rest of it. Atop the mound of viridian goop is the torso of a ultrapornstar goddess. Pendulous breasts hang from the front of her glittering chest, obscuring everything above her navel with gooey boob. Her eyes glitter with a predatory mirth, slightly darker in hue than the rest of her, a color matched by her plump, wet-looking lips. You need to defeat her if you ever want to lay claim to Dad’s fortune and make him proud!";
		celise.customDodge = "The goo twists a portion of its body out of the way of the attack, moving in a way that would be fatal for any vertebrate.";
		celise.customBlock = "Your attack sinks into the goo, the wound vanishing almost instantly as her surface recloses.";
		celise.plural = false;
		celise.lustVuln = 1;
		celise.meleeWeapon.attackVerb = "slap";
		celise.meleeWeapon.longName = "gooey psuedopod";
		celise.armor.longName = "gooey coverings";
		celise.armor.defense = 50;
		celise.physiqueRaw = 3;
		celise.reflexesRaw = 1;
		celise.aimRaw = 1;
		celise.intelligenceRaw = 1;
		celise.willpowerRaw = 1;
		celise.libidoRaw = 100;
		celise.HPMod = 100;
		celise.shieldsRaw = 0;
		celise.HPRaw = celise.HPMax();
		celise.energyRaw = 100;
		celise.lustRaw = 85;
		celise.resistances = new Array(0,0,0,0,0,0,0,0);
		celise.XP = 50;
		celise.level = 1;
		celise.credits = 0;
		
		celise.femininity = 90;
		celise.eyeType = 0;
		celise.eyeColor = "green";
		celise.tallness = 49;
		celise.thickness = 60;
		celise.tone = 50;
		celise.hairColor = "green";
	    celise.scaleColor = "green";
		celise.furColor = "green";
		celise.hairLength = 12;
		celise.hairType = 0;
		celise.beardLength = 0;
		celise.beardStyle = 0;
		celise.skinType = GLOBAL.GOO;
		celise.skinTone = "green";
		celise.skinFlags = new Array(GLOBAL.SQUISHY,GLOBAL.LUBRICATED,GLOBAL.AMORPHOUS);
		celise.faceType = 0;
		celise.faceFlags = new Array();
		celise.tongueType = 0;
		celise.lipMod = 1;
		celise.earType = 0;
		celise.antennae = 0;
		celise.antennaeType = 0;
		celise.horns = 0;
		celise.hornType = 0;
		celise.armType = 0;
		celise.gills = false;
		celise.wingType = 0;
		celise.legType = GLOBAL.GOOEY;
		celise.legCount = 1;
		celise.legFlags = new Array(GLOBAL.AMORPHOUS);
		//0 - Waist
		//1 - Middle of a long tail. Defaults to waist on bipeds.
		//2 - Between last legs or at end of long tail.
		//3 - On underside of a tail, used for driders and the like, maybe?
		celise.genitalSpot = 0;
		celise.tailType = 0;
		celise.tailCount = 0;
		celise.tailFlags = new Array();
		//Used to set cunt or dick type for cunt/dick tails!
		celise.tailGenitalArg = 0;
		//tailGenital:
		//0 - none.
		//1 - cock
		//2 - vagina
		celise.tailGenital = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		celise.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		celise.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		celise.hipRating = 15;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		celise.buttRating = 10;
		//No dicks here!
		celise.cocks = new Array();
		//balls
		celise.balls = 0;
		celise.cumMultiplier = 50;
		//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
		celise.cumQuality = 1;
		celise.cumType = GLOBAL.CUM;
		celise.ballSize = 24;
		celise.ballFullness = 100;
		//How many "normal" orgams worth of jizz your balls can hold.
		celise.ballEfficiency = 400;
		//Scales from 0 (never produce more) to infinity.
		celise.refractoryRate = 9999;
		celise.minutesSinceCum = 9000;
		celise.timesCum = 5674;
		celise.cockVirgin = false;
		celise.vaginalVirgin = false;
		celise.analVirgin = false;
		celise.vaginas = new Array();
		celise.createVagina();
		celise.vaginas[0].hymen = false;
		celise.vaginas[0].clits = 1;
		celise.vaginas[0].wetness = 5;
		celise.vaginas[0].looseness = 1;
		celise.vaginas[0].bonusCapacity = 10;
		//Goo is hyper friendly!
		celise.elasticity = 100;
		//Fertility is a % out of 100. 
		celise.fertility = 1;
		celise.clitLength = .5;
		celise.pregnancyMultiplier = 1;
		
		celise.breastRows[0].breastRating = 14;
		celise.nippleColor = "deep emerald";
		celise.milkMultiplier = 0;
		celise.milkType = GLOBAL.MILK;
		//The rate at which you produce milk. Scales from 0 to INFINITY.
		celise.milkRate = 1;
		celise.ass.wetness = 5;
	
	}
	//Rival!
	if (!justUpdate || (justUpdate && characters[GLOBAL.RIVAL].short == "uncreated"))
	{
		//Rival!
		characters[GLOBAL.RIVAL] = new Creature();
		rival = characters[GLOBAL.RIVAL];
		rival.short = "Jack/Jill";
		rival.originalRace = "human";
		rival.a = "";
		rival.capitalA = "";
		rival.long = "";
		rival.customDodge = "";
		rival.customBlock = "";
		rival.plural = false;
		rival.lustVuln = 1;
		rival.meleeWeapon.attackVerb = "punch";
		rival.meleeWeapon.longName = "fist";
		rival.armor.longName = "A-type personal defense suit";
		rival.armor.defense = 50;
		rival.physiqueRaw = 3;
		rival.reflexesRaw = 3;
		rival.aimRaw = 3;
		rival.intelligenceRaw = 3;
		rival.willpowerRaw = 3;
		rival.libidoRaw = 30;
		rival.HPMod = 20;
		rival.shieldsRaw = 0;
		rival.HPRaw = rival.HPMax();
		rival.energyRaw = 100;
		rival.lustRaw = 25;
		rival.resistances = new Array(1,1,1,1,1,1,1,1);
		rival.XP = 50;
		rival.level = 1;
		rival.credits = 1000;
		
		rival.femininity = 50;
		rival.eyeType = 0;
		rival.eyeColor = pc.eyeColor;
		rival.tallness = 65;
		rival.thickness = 50;
		rival.tone = 50;
		rival.hairColor = pc.hairColor;
	    rival.scaleColor = pc.scaleColor;
		rival.furColor = pc.furColor;
		rival.hairLength = 12;
		rival.hairType = 0;
		rival.beardLength = 0;
		rival.beardStyle = 0;
		rival.skinType = GLOBAL.SKIN;
		rival.skinTone = pc.skinTone;
		rival.skinFlags = new Array();
		rival.faceType = 0;
		rival.faceFlags = new Array();
		rival.tongueType = 0;
		rival.lipMod = 0;
		rival.earType = 0;
		rival.antennae = 0;
		rival.antennaeType = 0;
		rival.horns = 0;
		rival.hornType = 0;
		rival.armType = 0;
		rival.gills = false;
		rival.wingType = 0;
		rival.legType = GLOBAL.HUMAN;
		rival.legCount = 2;
		rival.legFlags = new Array(GLOBAL.PLANTIGRADE);
		//0 - Waist
		//1 - Middle of a long tail. Defaults to waist on bipeds.
		//2 - Between last legs or at end of long tail.
		//3 - On underside of a tail, used for driders and the like, maybe?
		rival.genitalSpot = 0;
		rival.tailType = 0;
		rival.tailCount = 0;
		rival.tailFlags = new Array();
		//Used to set cunt or dick type for cunt/dick tails!
		rival.tailGenitalArg = 0;
		//tailGenital:
		//0 - none.
		//1 - cock
		//2 - vagina
		rival.tailGenital = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		rival.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		rival.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		rival.hipRating = 4;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		rival.buttRating = 4;
		//No dicks here!
		rival.cocks = new Array();
		//balls
		rival.balls = 0;
		rival.cumMultiplier = pc.cumMultiplier;
		//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
		rival.cumQuality = 1;
		rival.cumType = GLOBAL.CUM;
		rival.ballSize = pc.ballSize;
		rival.ballFullness = pc.ballFullness;
		//How many "normal" orgams worth of jizz your balls can hold.
		rival.ballEfficiency = pc.ballFullness;
		//Scales from 0 (never produce more) to infinity.
		rival.refractoryRate = pc.refractoryRate;
		rival.minutesSinceCum = pc.minutesSinceCum;
		rival.timesCum = 55;
		
		//Goo is hyper friendly!
		rival.elasticity = 1;
		//Fertility is a % out of 100. 
		rival.fertility = 5;
		rival.clitLength = .5;
		rival.pregnancyMultiplier = 1;
		
		rival.breastRows[0].breastRating = 0;
		rival.nippleColor = pc.nippleColor;
		rival.milkMultiplier = 0;
		rival.milkType = GLOBAL.MILK;
		//The rate at which you produce milk. Scales from 0 to INFINITY.
		rival.milkRate = 0;
		rival.ass.wetness = 0;
		
	}
	
	if (!justUpdate || (justUpdate && characters[GLOBAL.GEOFF].short == "uncreated"))
	{
		characters[GLOBAL.GEOFF] = new Creature();
		geoff = characters[GLOBAL.GEOFF];
		geoff.short = "Geoff";
		geoff.originalRace = "human";
		geoff.a = "";
		geoff.capitalA = "";
		geoff.long = "";
		geoff.customDodge = "";
		geoff.customBlock = "";
		geoff.plural = false;
		geoff.lustVuln = 1;
		geoff.meleeWeapon.attackVerb = "punch";
		geoff.meleeWeapon.longName = "fist";
		geoff.armor.longName = "comfortable clothes";
		geoff.armor.defense = 50;
		geoff.physiqueRaw = 3;
		geoff.reflexesRaw = 3;
		geoff.aimRaw = 3;
		geoff.intelligenceRaw = 3;
		geoff.willpowerRaw = 3;
		geoff.libidoRaw = 30;
		geoff.HPMod = 20;
		geoff.shieldsRaw = 0;
		geoff.HPRaw = geoff.HPMax();
		geoff.energyRaw = 100;
		geoff.lustRaw = 25;
		geoff.resistances = new Array(1,1,1,1,1,1,1,1);
		geoff.XP = 50;
		geoff.level = 1;
		geoff.credits = 1000;
		
		geoff.inventory[0] = clone(items["0"]);
		geoff.inventory[1] = clone(items["1"]);
		geoff.inventory[2] = clone(items["2"]);
		geoff.typesBought[geoff.typesBought.length] = GLOBAL.ALL;
		geoff.sellMarkup = 1.3;
		geoff.buyMarkdown = .25;
		geoff.keeperSell = "<i>“You have items ready to be spiritually appraised and elevated, then?”</i>  Artie rubs his hands in anticipation as you approach his crate. <i>“Let’s see what you have and what they are, ahem, worth.”</i>\n";
		geoff.keeperBuy = "Geoff smiles at you as you carefully make your way over to him.\n\n<i>“Hey, [pc.name].  Looking to buy something?”</i>";
		geoff.keeperGreeting = "Artie nods at you as you enter the scrap yard hut, smiling peacefully as he closes his eyes and goes back to meditating over a large diode. Geoff is busy working on something in the back.";
		
		geoff.femininity = 20;
		geoff.eyeType = 0;
		geoff.eyeColor = "brown";
		geoff.tallness = 78;
		geoff.thickness = 20;
		geoff.tone = 70;
		geoff.hairColor = "brown";
		geoff.scaleColor = pc.scaleColor;
		geoff.furColor = pc.furColor;
		geoff.hairLength = 12;
		geoff.hairType = 0;
		geoff.beardLength = 0;
		geoff.beardStyle = 0;
		geoff.skinType = GLOBAL.SKIN;
		geoff.skinTone = pc.skinTone;
		geoff.skinFlags = new Array();
		geoff.faceType = 0;
		geoff.faceFlags = new Array();
		geoff.tongueType = 0;
		geoff.lipMod = 0;
		geoff.earType = 0;
		geoff.antennae = 0;
		geoff.antennaeType = 0;
		geoff.horns = 0;
		geoff.hornType = 0;
		geoff.armType = 0;
		geoff.gills = false;
		geoff.wingType = 0;
		geoff.legType = GLOBAL.HUMAN;
		geoff.legCount = 2;
		geoff.legFlags = new Array(GLOBAL.PLANTIGRADE);
		//0 - Waist
		//1 - Middle of a long tail. Defaults to waist on bipeds.
		//2 - Between last legs or at end of long tail.
		//3 - On underside of a tail, used for driders and the like, maybe?
		geoff.genitalSpot = 0;
		geoff.tailType = 0;
		geoff.tailCount = 0;
		geoff.tailFlags = new Array();
		//Used to set cunt or dick type for cunt/dick tails!
		geoff.tailGenitalArg = 0;
		//tailGenital:
		//0 - none.
		//1 - cock
		//2 - vagina
		geoff.tailGenital = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		geoff.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		geoff.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		geoff.hipRating = 4;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		geoff.buttRating = 4;
		//No dicks here!
		geoff.cocks = new Array();
		geoff.createCock();
		geoff.cocks[0].cLength = 6;
		geoff.cocks[0].cThickness = 1.75;
		//balls
		geoff.balls = 2;
		geoff.cumMultiplier = 3;
		//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
		geoff.cumQuality = 1;
		geoff.cumType = GLOBAL.CUM;
		geoff.ballSize = pc.ballSize;
		geoff.ballFullness = 10;
		//How many "normal" orgams worth of jizz your balls can hold.
		geoff.ballEfficiency = 10;
		//Scales from 0 (never produce more) to infinity.
		geoff.refractoryRate = 1;
		geoff.minutesSinceCum = 3650;
		geoff.timesCum = 55;
		
		//Goo is hyper friendly!
		geoff.elasticity = 1;
		//Fertility is a % out of 100. 
		geoff.fertility = 5;
		geoff.clitLength = .5;
		geoff.pregnancyMultiplier = 1;
		
		geoff.breastRows[0].breastRating = 0;
		geoff.nippleColor = "brown";
		geoff.milkMultiplier = 0;
		geoff.milkType = GLOBAL.MILK;
		//The rate at which you produce milk. Scales from 0 to INFINITY.
		geoff.milkRate = 0;
		geoff.ass.wetness = 0;
	}
	if (!justUpdate || (justUpdate && characters[GLOBAL.FLAHNE].short == "uncreated"))
	{
		characters[GLOBAL.FLAHNE] = new Creature();
		flahne = characters[GLOBAL.FLAHNE];
		flahne.short = "Flahne";
		flahne.originalRace = "loo'rahn";
		flahne.a = "";
		flahne.capitalA = "";
		flahne.long = "Placeholder";
		flahne.customDodge = "The goo twists a portion of its body out of the way of the attack, moving in a way that would be fatal for any vertebrate.";
		flahne.customBlock = "Your attack sinks into the goo, the wound vanishing almost instantly as her surface recloses.";
		flahne.plural = false;
		flahne.lustVuln = 1;
		flahne.meleeWeapon.attackVerb = "punch";
		flahne.meleeWeapon.longName = "semi-solid fist";
		flahne.armor.longName = "durable dermis";
		flahne.armor.defense = 10;
		flahne.physiqueRaw = 2;
		flahne.reflexesRaw = 3;
		flahne.aimRaw = 1;
		flahne.intelligenceRaw = 4;
		flahne.willpowerRaw = 1;
		flahne.libidoRaw = 65;
		flahne.HPMod = 15;
		flahne.shieldsRaw = 0;
		flahne.HPRaw = flahne.HPMax();
		flahne.energyRaw = 100;
		flahne.lustRaw = 15;
		flahne.resistances = new Array(0,0,0,0,0,0,0,0);
		flahne.XP = 50;
		flahne.level = 1;
		flahne.credits = 0;
		
		flahne.femininity = 90;
		flahne.eyeType = 0;
		flahne.eyeColor = "violet";
		flahne.tallness = 60;
		flahne.thickness = 80;
		flahne.tone = 0;
		flahne.hairColor = "amber";
		flahne.scaleColor = "yellow";
		flahne.furColor = "amber";
		flahne.hairLength = 18;
		flahne.hairType = 0;
		flahne.beardLength = 0;
		flahne.beardStyle = 0;
		flahne.skinType = GLOBAL.GOO;
		flahne.skinTone = "yellow";
		flahne.skinFlags = new Array(GLOBAL.SQUISHY,GLOBAL.LUBRICATED);
		flahne.faceType = 0;
		flahne.faceFlags = new Array();
		flahne.tongueType = 0;
		flahne.lipMod = 2;
		flahne.earType = 0;
		flahne.antennae = 2;
		flahne.antennaeType = GLOBAL.GOOEY;
		flahne.horns = 0;
		flahne.hornType = 0;
		flahne.armType = 0;
		flahne.gills = false;
		flahne.wingType = 0;
		flahne.legType = GLOBAL.GOOEY;
		flahne.legCount = 2;
		flahne.legFlags = new Array(GLOBAL.PLANTIGRADE);
		//0 - Waist
		//1 - Middle of a long tail. Defaults to waist on bipeds.
		//2 - Between last legs or at end of long tail.
		//3 - On underside of a tail, used for driders and the like, maybe?
		flahne.genitalSpot = 0;
		flahne.tailType = 0;
		flahne.tailCount = 0;
		flahne.tailFlags = new Array();
		//Used to set cunt or dick type for cunt/dick tails!
		flahne.tailGenitalArg = 0;
		//tailGenital:
		//0 - none.
		//1 - cock
		//2 - vagina
		flahne.tailGenital = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		flahne.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		flahne.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		flahne.hipRating = 13;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		flahne.buttRating = 13;
		//No dicks here!
		flahne.cocks = new Array();
		flahne.createCock();
		flahne.cocks[0].cThickness = 4;
		flahne.cocks[0].cLength = 16;
		flahne.cocks[0].addFlag(GLOBAL.LUBRICATED);
		flahne.cocks[0].addFlag(GLOBAL.SQUISHY);
		flahne.cocks[0].addFlag(GLOBAL.SMOOTH);
		//balls
		flahne.balls = 0;
		flahne.cumMultiplier = 50;
		//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
		flahne.cumQuality = 1;
		flahne.cumType = GLOBAL.CUM;
		flahne.ballSize = 0;
		flahne.ballFullness = 100;
		//How many "normal" orgams worth of jizz your balls can hold.
		flahne.ballEfficiency = 400;
		//Scales from 0 (never produce more) to infinity.
		flahne.refractoryRate = 9999;
		flahne.minutesSinceCum = 65;
		flahne.timesCum = 9001;
		flahne.cockVirgin = false;
		flahne.vaginalVirgin = false;
		flahne.analVirgin = false;
		flahne.vaginas = new Array();
		flahne.createVagina();
		flahne.vaginas[0].hymen = false;
		flahne.vaginas[0].clits = 1;
		flahne.vaginas[0].wetness = 4;
		flahne.vaginas[0].looseness = 1;
		flahne.vaginas[0].bonusCapacity = 100;
		//Goo is hyper friendly!
		flahne.elasticity = 3;
		//Fertility is a % out of 100. 
		flahne.fertility = 15;
		flahne.clitLength = .5;
		flahne.pregnancyMultiplier = 1;
		
		flahne.breastRows[0].breastRating = 15;
		flahne.nippleColor = "honey";
		flahne.milkMultiplier = 0;
		flahne.milkType = GLOBAL.MILK;
		//The rate at which you produce milk. Scales from 0 to INFINITY.
		flahne.milkRate = 0;
		flahne.ass.wetness = 3;
	}	
	trace("JUST BEFORE ZIL UPDATE. Justupdate: " + justUpdate + " short: " + characters[GLOBAL.ZILPACK].short);
	if (!justUpdate || (justUpdate && characters[GLOBAL.ZILPACK].short == "uncreated"))
	{
		trace("UPDATING ZIL");
		characters[GLOBAL.ZILPACK] = new Creature();
		zilpack = characters[GLOBAL.ZILPACK];
		zilpack.short = "two zil";
		zilpack.originalRace = "zil";
		zilpack.a = "the ";
		zilpack.capitalA = "The ";
		zilpack.long = "There are two zil here, one on either side of you. Both are males, as determined by their exposed, dangling genitalia. Their wings flutter incessantly behind them; they can’t fly in the enclosed space, yet the wingbeats keep their genitals at just the right height to waft their sweet musk in your direction. Their penises are about six inches long with tight, hairless sacks underneath. As prisoners, they are without weapons, not even stingers that you would expect on such a wasp-like foe. They do have almost head-to-toe chitin to protect them, some black, some yellow.";
		zilpack.customDodge = "The two zil zip out of the way with a swift contortion of their agile frames.";
		zilpack.customBlock = "The two zil's chitinous armor deflects your attack.";
		zilpack.plural = true;
		zilpack.lustVuln = 1;
		zilpack.meleeWeapon.attackVerb = "punch";
		zilpack.meleeWeapon.longName = "fists";
		zilpack.armor.longName = "chitinous plating";
		zilpack.armor.defense = 2;
		zilpack.physiqueRaw = 2;
		zilpack.reflexesRaw = 2;
		zilpack.aimRaw = 1;
		zilpack.intelligenceRaw = 1;
		zilpack.willpowerRaw = 1;
		zilpack.libidoRaw = 40;
		zilpack.shieldsRaw = 0;
		zilpack.energyRaw = 100;
		zilpack.lustRaw = 45;
		zilpack.resistances = new Array(1,1,1,1,1,1,1,1);
		zilpack.XP = 55;
		zilpack.level = 1;
		zilpack.credits = 0;
		zilpack.HPMod = 40;
		zilpack.HPRaw = zilpack.HPMax();
		
		zilpack.createPerk("Multiple Attacks",0,0,0,0,"");
		
		zilpack.femininity = 35;
		zilpack.eyeType = GLOBAL.BEE;
		zilpack.eyeColor = "black";
		zilpack.tallness = 54;
		zilpack.thickness = 20;
		zilpack.tone = 70;
		zilpack.hairColor = "black";
		zilpack.scaleColor = pc.scaleColor;
		zilpack.furColor = "yellow";
		zilpack.hairLength = 3;
		zilpack.hairType = GLOBAL.BEE;
		zilpack.beardLength = 0;
		zilpack.beardStyle = 0;
		zilpack.skinType = GLOBAL.CHITIN;
		zilpack.skinTone = "black";
		zilpack.skinFlags = new Array();
		zilpack.faceType = GLOBAL.BEE;
		zilpack.faceFlags = new Array();
		zilpack.tongueType = GLOBAL.BEE;
		zilpack.lipMod = 0;
		zilpack.earType = 0;
		zilpack.antennae = 2;
		zilpack.antennaeType = GLOBAL.BEE;
		zilpack.horns = 0;
		zilpack.hornType = 0;
		zilpack.armType = GLOBAL.BEE;
		zilpack.gills = false;
		zilpack.wingType = GLOBAL.BEE;
		zilpack.legType = GLOBAL.BEE;
		zilpack.legCount = 2;
		zilpack.legFlags = new Array(GLOBAL.PLANTIGRADE);
		//0 - Waist
		//1 - Middle of a long tail. Defaults to waist on bipeds.
		//2 - Between last legs or at end of long tail.
		//3 - On underside of a tail, used for driders and the like, maybe?
		zilpack.genitalSpot = 0;
		zilpack.tailType = 0;
		zilpack.tailCount = 0;
		zilpack.tailFlags = new Array();
		//Used to set cunt or dick type for cunt/dick tails!
		zilpack.tailGenitalArg = 0;
		//tailGenital:
		//0 - none.
		//1 - cock
		//2 - vagina
		zilpack.tailGenital = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		zilpack.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		zilpack.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		zilpack.hipRating = 0;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		zilpack.buttRating = 2;
		//No dicks here!
		zilpack.cocks = new Array();
		zilpack.createCock();
		zilpack.cocks[0].cLength = 6;
		zilpack.cocks[0].cThickness = 1.75;
		zilpack.createCock();
		zilpack.cocks[1].cLength = 6;
		zilpack.cocks[1].cThickness = 1.75;
		//balls
		zilpack.balls = 2;
		zilpack.cumMultiplier = 6;
		//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
		zilpack.cumQuality = 1;
		zilpack.cumType = GLOBAL.HONEY;
		zilpack.ballSize = pc.ballSize;
		zilpack.ballFullness = 1;
		//How many "normal" orgams worth of jizz your balls can hold.
		zilpack.ballEfficiency = 10;
		//Scales from 0 (never produce more) to infinity.
		zilpack.refractoryRate = 6;
		zilpack.minutesSinceCum = 3650;
		zilpack.timesCum = 321;
		
		//Goo is hyper friendly!
		zilpack.elasticity = 1;
		//Fertility is a % out of 100. 
		zilpack.fertility = 5;
		zilpack.clitLength = .5;
		zilpack.pregnancyMultiplier = 1;
		
		zilpack.breastRows[0].breastRating = 0;
		zilpack.nippleColor = "black";
		zilpack.milkMultiplier = 0;
		zilpack.milkType = GLOBAL.HONEY;
		//The rate at which you produce milk. Scales from 0 to INFINITY.
		zilpack.milkRate = 0;
		zilpack.ass.wetness = 0;
	}
	if (!justUpdate || (justUpdate && characters[GLOBAL.ZIL].short == "uncreated"))
	{
		trace("UPDATING ZIL!");
		//Zil mob a singular clone of zilpack!
		characters[GLOBAL.ZIL] = clone(characters[GLOBAL.ZILPACK]);
		zil = characters[GLOBAL.ZIL];
		zil.plural = false;
		zil.short = "zil";
		zil.removeCock(0,1);
		zil.HPMod = 0;
		zil.XP = 20;
		zil.HPRaw = zil.HPMax();
		trace("ZIL SHORT: " + zil.short + " characters[ZIL]: " + characters[GLOBAL.ZIL].short);
	}
	
	if (!justUpdate || (justUpdate && characters[GLOBAL.PENNY].short == "uncreated"))
	{
		characters[GLOBAL.PENNY] = new Creature();
		penny = characters[GLOBAL.PENNY];
		penny.short = "Penny";
		penny.originalRace = "human";
		penny.a = "";
		penny.capitalA = "";
		penny.long = "uncreated";
		penny.customDodge = "uncreated";
		penny.customBlock = "uncreated";
		penny.plural = false;
		penny.lustVuln = 1;
		penny.meleeWeapon.attackVerb = "smack";
		penny.meleeWeapon.longName = "tonfas";
		penny.armor.longName = "U.G.C. Peacekeeper uniform";
		penny.armor.defense = 0;
		penny.physiqueRaw = 10;
		penny.reflexesRaw = 8;
		penny.aimRaw = 6;
		penny.intelligenceRaw = 4;
		penny.willpowerRaw = 3;
		penny.libidoRaw = 40;
		penny.shieldsRaw = 20;
		penny.energyRaw = 100;
		penny.lustRaw = 85;
		penny.resistances = new Array(0,0,0,0,0,0,0,0);
		penny.XP = 50;
		penny.level = 1;
		penny.credits = 0;
		penny.HPMod = 20;
		penny.HPRaw = penny.HPMax();
		
		penny.femininity = 85;
		penny.eyeType = 0;
		penny.eyeColor = "blue";
		penny.tallness = 60;
		penny.thickness = 40;
		penny.tone = 70;
		penny.hairColor = "red";
		penny.scaleColor = "bronze";
		penny.furColor = "tawny";
		penny.hairLength = 3;
		penny.hairType = 0;
		penny.beardLength = 0;
		penny.beardStyle = 0;
		penny.skinType = GLOBAL.FUR;
		penny.skinTone = "pink";
		penny.skinFlags = new Array();
		penny.faceType = GLOBAL.VULPINE;
		penny.faceFlags = new Array();
		penny.tongueType = 0;
		penny.lipMod = 1;
		penny.earType = GLOBAL.VULPINE;
		penny.antennae = 0;
		penny.antennaeType = 0;
		penny.horns = 0;
		penny.hornType = 0;
		penny.armType = 0;
		penny.gills = false;
		penny.wingType = 0;
		penny.legType = 0;
		penny.legCount = 2;
		zilpack.legFlags = new Array(GLOBAL.PLANTIGRADE);
		//0 - Waist
		//1 - Middle of a long tail. Defaults to waist on bipeds.
		//2 - Between last legs or at end of long tail.
		//3 - On underside of a tail, used for driders and the like, maybe?
		penny.genitalSpot = 0;
		penny.tailType = GLOBAL.VULPINE;
		penny.tailCount = 1;
		penny.tailFlags = new Array(GLOBAL.FLUFFY,GLOBAL.LONG,GLOBAL.THICK,GLOBAL.FURRED);
		//Used to set cunt or dick type for cunt/dick tails!
		penny.tailGenitalArg = 0;
		//tailGenital:
		//0 - none.
		//1 - cock
		//2 - vagina
		penny.tailGenital = 0;
		//Tail venom is a 0-100 slider used for tail attacks. Recharges per hour.
		penny.tailVenom = 0;
		//Tail recharge determines how fast venom/webs comes back per hour.
		penny.tailRecharge = 5;
		//hipRating
		//0 - boyish
		//2 - slender
		//4 - average
		//6 - noticable/ample
		//10 - curvy//flaring
		//15 - child-bearing/fertile
		//20 - inhumanly wide
		penny.hipRating = 8;
		//buttRating
		//0 - buttless
		//2 - tight
		//4 - average
		//6 - noticable
		//8 - large
		//10 - jiggly
		//13 - expansive
		//16 - huge
		//20 - inconceivably large/big/huge etc
		penny.buttRating = 7;
		//No dicks here!
		penny.cocks = new Array();
		//balls
		penny.balls = 0;
		penny.cumMultiplier = 1.5;
		//Multiplicative value used for impregnation odds. 0 is infertile. Higher is better.
		penny.cumQuality = 1;
		penny.cumType = GLOBAL.CUM;
		penny.ballSize = 2;
		penny.ballFullness = 100;
		//How many "normal" orgams worth of jizz your balls can hold.
		penny.ballEfficiency = 4;
		//Scales from 0 (never produce more) to infinity.
		penny.refractoryRate = 9999;
		penny.minutesSinceCum = 9000;
		penny.timesCum = 785;
		penny.cockVirgin = true;
		penny.vaginalVirgin = false;
		penny.analVirgin = false;
		penny.vaginas = new Array();
		penny.createVagina();
		penny.vaginas[0].hymen = false;
		penny.vaginas[0].clits = 1;
		penny.vaginas[0].wetness = 2;
		penny.vaginas[0].looseness = 1;
		penny.vaginas[0].bonusCapacity = 0;
		//Goo is hyper friendly!
		penny.elasticity = 1;
		//Fertility is a % out of 100. 
		penny.fertility = 1;
		penny.clitLength = .5;
		penny.pregnancyMultiplier = 1;
		
		penny.breastRows[0].breastRating = 6;
		penny.nippleColor = "pink";
		penny.milkMultiplier = 0;
		penny.milkType = GLOBAL.MILK;
		//The rate at which you produce milk. Scales from 0 to INFINITY.
		penny.milkRate = 1;
		penny.ass.wetness = 0;
	}
}