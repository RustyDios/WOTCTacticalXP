//---------------------------------------------------------------------------------------
//  FILE:   UITacticalHUD_SoldierInfo_WOTCTacticalXP.uc                                    
//           
//	CREATED BY GRIMY
//	BEGIN EDITS BY RUSTYDIOS	02/03/21	02:00
//	LAST EDITED BY RUSTYDIOS	25/03/21	01:30
// 
//---------------------------------------------------------------------------------------
class UITacticalHUD_SoldierInfo_WOTCTacticalXP extends UITacticalHUD_SoldierInfo config(WOTCTacticalXP);

var localized string strKills, strAvatarNickName;

var config bool bFULL_NUM_DISPLAY, bNO_NUM_DISPLAY, bUSE_XPICON;
var config string strAvatarClassIcon, strADVENTClassIcon, strAliensClassIcon, strCivvieClassIcon;

simulated function SetStats( XGUnit kActiveUnit )
{
	local XComGameState_Unit UnitState;
	local string charName, charNickname, charRank, charClass;
	local bool isLeader, isLeveledUp, showBonus, showPenalty;
	local float aimPercent;
	local array<UISummary_UnitEffect> BonusEffects, PenaltyEffects; 
	//local X2SoldierClassTemplateManager SoldierTemplateManager;
	local XComGameState_ResistanceFaction FactionState;
	local StateObjectReference BondmateRef;
	local SoldierBond BondInfo;

	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kActiveUnit.ObjectID));
	FactionState = UnitState.GetResistanceFaction();

    // SPECIAL HANDLING FOR THE COMMANDERS AVATAR
	if( UnitState.GetMyTemplateName() == 'AdvPsiWitchM2' )
	{
		//yes we swap the name and nickname fields over
		charNickname = UnitState.GetName(eNameType_Full);
		charName = strAvatarNickName;

		if (charName == "")		//no nickname set in localisation
		{						//drop full name from nick field into name field
			charNickname = "";
			charName = UnitState.GetName(eNameType_Full);

		}

		charRank = "img:///UILibrary_Common.rank_fieldmarshall";
		// ===== REMOVED HARDCODE TO PLAIN OLD PSI CLASS ICON ===== //
		//SoldierTemplateManager = class'X2SoldierClassTemplateManager'.static.GetSoldierClassTemplateManager();
		//charClass = SoldierTemplateManager.FindSoldierClassTemplate('PsiOperative').IconImage;
        charClass = "img:///" $default.strAvatarClassIcon;
		aimPercent = UnitState.GetCurrentStat(eStat_Offense);
	}
	else 
	{
		// ========== SWAP NAME AND NICKNAME =========== //
		// ===== TOP SMALL LETTER TEXT (NICKNAME) ===== //
		charNickname = UnitState.GetName(eNameType_FullNick);		//first 'nick' last

		charNickname = Repl(charNickname, "<font color='#C08EDA'>","", false);	//sanitise PsiOverhaul v3's colour tags
		charNickname = Repl(charNickname, "</font>","", false);

		charNickname = Repl(charNickname, "<font color='#B6B3E3'>","", false);	//sanitise Psionic's colour tags
		charNickname = Repl(charNickname, "</font>","", false);

		// ===== APPEND BIG TEXT WITH KC+ (NAME) ===== //
		charName = GetPromotionProgress(UnitState) ;				//promo icon x/y or Kills: x/y 

		if (charName != "")											//char name already has kills
		{
			if (UnitState.GetNickName() != "")						//unit nickname isn't nothing
			{
				charName @= ":" @UnitState.GetNickName() ;			//===== kills : unit nickname
			}
			else													//kills but no nickname
			{														//append unit name
				charName @= ":" @UnitState.GetName(eNameType_Full);	//===== kills : first last
			}
		}
		else														//char name has no kill display
		{
			if (UnitState.GetNickName() != "")						//unit nickname isn't nothing
			{
				charName = UnitState.GetNickName() ;				//===== Just Nickname
			}
		}
		
		if (charName == "")											//no kills, no nickname, 'backup to default'
		{															//drop full name from nick field into name field
			charNickname = "";
			charName = UnitState.GetName(eNameType_Full);			//===== Just First Last
		}

		// ===== CREATE THE REST OF THE SOLDIER INFO PANEL DETAILS ===== //
		if( UnitState.IsSoldier() )
		{
			//charRank = class'UIUtilities_Image'.static.GetRankIcon(UnitState.GetRank(), UnitState.GetSoldierClassTemplateName());
			//charClass = UnitState.GetSoldierClassTemplate().IconImage;
            charRank = UnitState.GetSoldierRankIcon();      // CHL Issue #408
			charClass = UnitState.GetSoldierClassIcon();    // CHL Issue #106

			isLeveledUp = UnitState.CanRankUpSoldier();		// show + icon if can level up
			aimPercent = UnitState.GetCurrentStat(eStat_Offense);
		}
		else if( UnitState.IsCivilian() )
		{
			//charRank = string(-2); // TODO: show civilian icon 
			//charRank = "img:///UILibrary_Common.rank_rookie";
			charClass = "img:///" $default.strCivvieClassIcon;
			aimPercent = -1;
		}
		else // is anything else, advent get advent icon, everything else gets alienhead
		{
			//charRank = string(99); //TODO: show alien icon
			//charRank = "img:///UILibrary_Common.rank_rookie";
			//charRank = GetHUDHeadIcon(); //TODO: Maybe?

			//charClass = UnitState.IsAdvent() ? "img:///UILibrary_Common.UIEvent_advent" : "img:///UILibrary_Common.UIEvent_alien"; //<<this is an incorrect icon size in the CHL! these are 32x32 when they should be 64x64
            charClass = UnitState.IsAdvent() ? "img:///" $default.strADVENTClassIcon : "img:///" $default.strAliensClassIcon;
			aimPercent = -1;
		}
	}

	// TODO: wtf is this used for ?
	isLeader = false;

	// ===== Buff/debuff arrows ===== //
	BonusEffects = UnitState.GetUISummary_UnitEffectsByCategory(ePerkBuff_Bonus);
	PenaltyEffects = UnitState.GetUISummary_UnitEffectsByCategory(ePerkBuff_Penalty);

	showBonus = (BonusEffects.length > 0 ); 
	showPenalty = (PenaltyEffects.length > 0);

	// ===== ACTUALLY SET THE NEW DETAILS ===== //
	AS_SetStats(charName, charNickname, charRank, charClass, isLeader, isLeveledUp, aimPercent, showBonus, showPenalty);
	
	// ===== CLASS ICON PER RANK FOR HERO UNITS ===== //
	//	NEEDS TO BE SET AFTER THE MAIN IS SET TO OVERRIDE THE RANK ICON FROM ABOVE
    if (FactionState != none)
    {
        AS_SetFactionIcon(FactionState.GetFactionIcon());
    }

	// ===== BOND INDICATORS ===== //
	//	NEEDS TO BE SET AFTER THE MAIN IS SET ABOVE TO SHOW THE FLAG NEXT TO IT
	//	WORKS WITH COLOUR CODED BONDS MOD, WOO HOO
	if( UnitState.HasSoldierBond(BondmateRef, BondInfo) )
	{
		AS_SetBondInfo(BondInfo.BondLevel, `XCOMHQ.IsUnitInSquad(BondmateRef));
		BondIcon.SetBondLevel(BondInfo.BondLevel);
		BondIcon.SetBondmateTooltip(BondmateRef);
	}
	else
	{
		AS_SetBondInfo(-1, false);
		BondIcon.SetBondLevel(-1);
		BondIcon.SetBondmateTooltip(BondmateRef); //NoneRef
	}
}

///////////////////////////////////////////////////////////////////////
//	CALCULATE THE AMOUNT OF XP TO DISPLAY
//	A HYBRID OF ORIGINAL MODS FUNCTION AND DETAILED SOLDIER LISTS
///////////////////////////////////////////////////////////////////////

function string GetPromotionProgress(XComGameState_Unit UnitState)
{
	local string promoteProgress;
    local int NumKills;
	local X2SoldierClassTemplate ClassTemplate;

    //BAIL FOR NON SOLDIER UNITS
	if (UnitState.IsSoldier())
	{
		ClassTemplate = UnitState.GetSoldierClassTemplate();
	}
	else
	{
		return "";
	}

    // BAIL FOR NO CLASS OR UNITS THAT DONT RANK UP (PSI OPS, BUILDABLE UNITS, SHEN, CENTRAL, VIPS) OR CONFIG OVERRIDE
	if (ClassTemplate == none || ClassTemplate.bBlockRankingUp || default.bNO_NUM_DISPLAY)
	{
		return "";
	}

	// BAIL FOR MAX RANK UNITS THAT ARE NOT ROOKIES (AS ROOKIE HAS ONLY 1 RANK SO WOULD ALWAYS BE MAX RANK)
	if (UnitState.GetSoldierRank() >= ClassTemplate.GetMaxConfiguredRank() && ClassTemplate.DataName != 'Rookie')
	{
		return "";
	}

    // ===== DISPLAY ===== //
    if (default.bFULL_NUM_DISPLAY)
    {
		// ===== CALCULATE KILL/XP ===== //
		NumKills = Round(UnitState.KillCount * ClassTemplate.KillAssistsPerKill);

		// Increase kills for WetWork bonus if appropriate - DEPRECATED
		NumKills += Round(UnitState.WetWorkKills * class'X2ExperienceConfig'.default.NumKillsBonus * ClassTemplate.KillAssistsPerKill);

		// Add in bonus kills
		NumKills += Round(UnitState.BonusKills * ClassTemplate.KillAssistsPerKill);

		//  Add number of kills from assists
		NumKills += Round(UnitState.KillAssistsCount);

		//  Add number of kills from psi assists
		NumKills += Round(UnitState.PsiCredits);

		// Add required kills of StartingRank
		NumKills += class'X2ExperienceConfig'.static.GetRequiredKills(UnitState.StartingRank) * ClassTemplate.KillAssistsPerKill;

		// Add Non-tactical kills (from covert actions)
		NumKills += UnitState.NonTacticalKills * ClassTemplate.KillAssistsPerKill;

	    promoteProgress = NumKills $ "/" $ class'X2ExperienceConfig'.static.GetRequiredKills(UnitState.GetSoldierRank() + 1) * ClassTemplate.KillAssistsPerKill;
    }
    else
    {
        promoteProgress = UnitState.GetTotalNumKills() $ "/" $ class'X2ExperienceConfig'.static.GetRequiredKills(UnitState.GetSoldierRank() + 1);
    }

    if (default.bUSE_XPICON)
    {
	    return class'UIUtilities_Text'.static.InjectImage(class'UIUtilities_Image'.const.HTML_PromotionIcon, 16, 20, 0) $ "</img>" @ promoteProgress;
    }

    return strKills @ promoteProgress;
}
    