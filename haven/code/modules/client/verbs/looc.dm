//////////	LOOC CODE LIFTED WHOLESALE FROM CITADEL, DECEMBER 2017. ALL CREDITS GOES TO POOJAWA, TALKINGCACTUS, DEATHRIDE, AND FRIENDS. ALSO, THE AGPL.

/client/verb/looc(msg as text)
	set name = "LOOC"
	set desc = "Local OOC, seen only by those in view."
	set category = "OOC"

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'> Speech is currently admin-disabled.</span>")
		return

	if(!mob)	return
	if(IsGuestKey(key))
		to_chat(src, "Guests may not use OOC.")
		return

	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)
		return

	if(!(prefs.toggles & CHAT_OOC))
		to_chat(src, "<span class='danger'> You have OOC muted.</span>")
		return

	if(!holder)
		if(!GLOB.ooc_allowed)
			to_chat(src, "<span class='danger'> OOC is globally muted</span>")
			return
		if(!GLOB.dooc_allowed && (mob.stat == DEAD))
			to_chat(usr, "<span class='danger'> OOC for dead mobs has been turned off.</span>")
			return
		if(prefs.muted & MUTE_OOC)
			to_chat(src, "<span class='danger'> You cannot use OOC (muted).</span>")
			return
		if(handle_spam_prevention(msg,MUTE_OOC))
			return
		if(findtext(msg, "byond://"))
			to_chat(src, "<B>Advertising other servers is not allowed.</B>")
			log_admin("[key_name(src)] has attempted to advertise in LOOC: [msg]")
			return

	log_ooc("(LOCAL) [mob.name]/[key] : [msg]")
	mob.log_message("(LOCAL): [msg]", INDIVIDUAL_OOC_LOG)

	var/list/heard = get_hearers_in_view(7, get_top_level_mob(src.mob))
	for(var/mob/M in heard)
		if(!M.client)
			continue
		var/client/C = M.client
		if (C in GLOB.admins)
			continue //they are handled after that

		if (isobserver(M))
			continue //Also handled later.

		if(C.prefs.toggles & CHAT_OOC)
//			var/display_name = src.key
//			if(holder)
//				if(holder.fakekey)
//					if(C.holder)
//						display_name = "[holder.fakekey]/([src.key])"
//				else
//					display_name = holder.fakekey
			to_chat(C,"<font color='#6699CC'><span class='ooc'><span class='prefix'>LOOC:</span> <EM>[src.mob.name]:</EM> <span class='message'>[msg]</span></span></font>")

	for(var/client/C in GLOB.admins)
		if(C.prefs.toggles & CHAT_OOC)
			var/prefix = "(R)LOOC"
			if (C.mob in heard)
				prefix = "LOOC"
			to_chat(C,"<font color='#6699CC'><span class='ooc'><span class='prefix'>[prefix]:</span> <EM>[src.key]/[src.mob.name]:</EM> <span class='message'>[msg]</span></span></font>")

	/*for(var/mob/dead/observer/G in world)
		if(!G.client)
			continue
		var/client/C = G.client
		if (C in GLOB.admins)
			continue //handled earlier.
		if(C.prefs.toggles & CHAT_OOC)
			var/prefix = "(G)LOOC"
			if (C.mob in heard)
				prefix = "LOOC"
		to_chat(C,"<font color='#6699CC'><span class='ooc'><span class='prefix'>[prefix]:</span> <EM>[src.key]/[src.mob.name]:</EM> <span class='message'>[msg]</span></span></font>")*/

//I have no idea what the heck do these procs do but it's needed

/mob/proc/get_top_level_mob()
	if(istype(src.loc,/mob)&&src.loc!=src)
		var/mob/M=src.loc
		return M.get_top_level_mob()
	return src

proc/get_top_level_mob(var/mob/S)
	if(istype(S.loc,/mob)&&S.loc!=S)
		var/mob/M=S.loc
		return M.get_top_level_mob()
	return S