/////////////////////////////////////////////////////////////////////
//			THE GREAT (crappy) LOOC PORT, DECEMBER 2017			   //
//																   //
//	I have no idea what I'm doing.	-tori						   //
/////////////////////////////////////////////////////////////////////

GLOBAL_VAR_INIT(looc_allowed, 1)
GLOBAL_VAR_INIT(dlooc_allowed, 1)

//LOOC toggles
/client/verb/listen_looc()
	set name = "Show/Hide LOOC"
	set category = "Preferences"
	set desc = "Toggles seeing LocalOutOfCharacter chat"
	prefs.chat_toggles ^= CHAT_LOOC
	prefs.save_preferences()
	src << "You will [(prefs.chat_toggles & CHAT_LOOC) ? "now" : "no longer"] see messages on the LOOC channel."
	SSblackbox.record_feedback("tally", "admin_verb", 1, "TLOOC") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/datum/admins/proc/togglelooc()
	set category = "Server"
	set desc="Fukken metagamers"
	set name="Toggle LOOC"
	toggle_looc()
	log_admin("[key_name(usr)] toggled LOOC.")
	message_admins("[key_name_admin(usr)] toggled LOOC.")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "TLOOC") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/proc/toggle_looc(toggle = null)
	if(toggle != null) //if we're specifically en/disabling ooc
		if(toggle != GLOB.looc_allowed)
			GLOB.looc_allowed = toggle
		else
			return
	else //otherwise just toggle it
		GLOB.looc_allowed = !GLOB.looc_allowed
	world << "<B>The LOOC channel has been globally [GLOB.looc_allowed ? "enabled" : "disabled"].</B>"

/datum/admins/proc/toggleloocdead()
	set category = "Server"
	set desc="Toggle dis bitch"
	set name="Toggle Dead LOOC"
	GLOB.dlooc_allowed = !( GLOB.dlooc_allowed )

	log_admin("[key_name(usr)] toggled Dead LOOC.")
	message_admins("[key_name_admin(usr)] toggled Dead LOOC.")
	SSblackbox.record_feedback("tally", "admin_verb", 1, "TDLOOC") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!