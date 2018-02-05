GLOBAL_LIST_EMPTY(antagonists)

/datum/antagonist
	var/name = "Antagonist"
	var/roundend_category = "other antagonists"				//Section of roundend report, datums with same category will be displayed together, also default header for the section
	var/show_in_roundend = TRUE								//Set to false to hide the antagonists from roundend report
	var/datum/mind/owner						//Mind that owns this datum
	var/silent = FALSE							//Silent will prevent the gain/lose texts to show
	var/can_coexist_with_others = TRUE			//Whether or not the person will be able to have more than one datum
	var/list/typecache_datum_blacklist = list()	//List of datums this type can't coexist with
	var/delete_on_mind_deletion = TRUE
	var/job_rank
	var/replace_banned = TRUE //Should replace jobbaned player with ghosts if granted.
	var/list/objectives = list()
<<<<<<< HEAD:code/datums/antagonists/antag_datum.dm
=======
	var/antag_memory = ""//These will be removed with antag datum
	
	//Antag panel properties
	var/show_in_antagpanel = TRUE	//This will hide adding this antag type in antag panel, use only for internal subtypes that shouldn't be added directly but still show if possessed by mind
	var/antagpanel_category = "Uncategorized"	//Antagpanel will display these together, REQUIRED
	var/show_name_in_check_antagonists = FALSE //Will append antagonist name in admin listings - use for categories that share more than one antag type
>>>>>>> 126a544... Slaughter demon, Morph, ERT / Deathsquad antag datums. (#35156):code/modules/antagonists/_common/antag_datum.dm

/datum/antagonist/New(datum/mind/new_owner)
	GLOB.antagonists += src
	typecache_datum_blacklist = typecacheof(typecache_datum_blacklist)
	if(new_owner)
		owner = new_owner

/datum/antagonist/Destroy()
	GLOB.antagonists -= src
	if(owner)
		LAZYREMOVE(owner.antag_datums, src)
	owner = null
	return ..()

/datum/antagonist/proc/can_be_owned(datum/mind/new_owner)
	. = TRUE
	var/datum/mind/tested = new_owner || owner
	if(tested.has_antag_datum(type))
		return FALSE
	for(var/i in tested.antag_datums)
		var/datum/antagonist/A = i
		if(is_type_in_typecache(src, A.typecache_datum_blacklist))
			return FALSE

/datum/antagonist/proc/on_body_transfer(mob/living/old_body, mob/living/new_body)
	remove_innate_effects(old_body)
	apply_innate_effects(new_body)

//This handles the application of antag huds/special abilities
/datum/antagonist/proc/apply_innate_effects(mob/living/mob_override)
	return

//This handles the removal of antag huds/special abilities
/datum/antagonist/proc/remove_innate_effects(mob/living/mob_override)
	return

//Assign default team and creates one for one of a kind team antagonists
/datum/antagonist/proc/create_team(datum/team/team)
	return

//Proc called when the datum is given to a mind.
/datum/antagonist/proc/on_gain()
	if(owner && owner.current)
		if(!silent)
			greet()
		apply_innate_effects()
		if(is_banned(owner.current) && replace_banned)
			replace_banned_player()

/datum/antagonist/proc/is_banned(mob/M)
	if(!M)
		return FALSE
	. = (jobban_isbanned(M,"Syndicate") || (job_rank && jobban_isbanned(M,job_rank)))

/datum/antagonist/proc/replace_banned_player()
	set waitfor = FALSE

	var/list/mob/dead/observer/candidates = pollCandidatesForMob("Do you want to play as a [name]?", "[name]", null, job_rank, 50, owner.current)
	var/mob/dead/observer/theghost = null
	if(candidates.len)
		theghost = pick(candidates)
		to_chat(owner, "Your mob has been taken over by a ghost! Appeal your job ban if you want to avoid this in the future!")
		message_admins("[key_name_admin(theghost)] has taken control of ([key_name_admin(owner.current)]) to replace a jobbaned player.")
		owner.current.ghostize(0)
		owner.current.key = theghost.key

/datum/antagonist/proc/on_removal()
	remove_innate_effects()
	if(owner)
		LAZYREMOVE(owner.antag_datums, src)
		if(!silent && owner.current)
			farewell()
	var/datum/team/team = get_team()
	if(team)
		team.remove_member(owner)
	qdel(src)

/datum/antagonist/proc/greet()
	return

/datum/antagonist/proc/farewell()
	return

//Returns the team antagonist belongs to if any.
/datum/antagonist/proc/get_team()
	return

//Individual roundend report
/datum/antagonist/proc/roundend_report()
	var/list/report = list()

	if(!owner)
		CRASH("antagonist datum without owner")

	report += printplayer(owner)

	var/objectives_complete = TRUE
	if(owner.objectives.len)
		report += printobjectives(owner)
		for(var/datum/objective/objective in owner.objectives)
			if(!objective.check_completion())
				objectives_complete = FALSE
				break

	if(owner.objectives.len == 0 || objectives_complete)
		report += "<span class='greentext big'>The [name] was successful!</span>"
	else
		report += "<span class='redtext big'>The [name] has failed!</span>"

	return report.Join("<br>")

//Displayed at the start of roundend_category section, default to roundend_category header
/datum/antagonist/proc/roundend_report_header()
	return 	"<span class='header'>The [roundend_category] were:</span><br>"

//Displayed at the end of roundend_category section
/datum/antagonist/proc/roundend_report_footer()
	return

//Should probably be on ticker or job ss ?
/proc/get_antagonists(antag_type,specific = FALSE)
	. = list()
	for(var/datum/antagonist/A in GLOB.antagonists)
		if(!specific && istype(A,antag_type) || specific && A.type == antag_type)
			. += A.owner



//This datum will autofill the name with special_role
//Used as placeholder for minor antagonists, please create proper datums for these
/datum/antagonist/auto_custom
<<<<<<< HEAD:code/datums/antagonists/antag_datum.dm
=======
	show_in_antagpanel = FALSE
	antagpanel_category = "Other"
	show_name_in_check_antagonists = TRUE
>>>>>>> 126a544... Slaughter demon, Morph, ERT / Deathsquad antag datums. (#35156):code/modules/antagonists/_common/antag_datum.dm

/datum/antagonist/auto_custom/on_gain()
	..()
	name = owner.special_role
	//Add all objectives not already owned by other datums to this one.
	var/list/already_registered_objectives = list()
	for(var/datum/antagonist/A in owner.antag_datums)
		if(A == src)
			continue
		else
			already_registered_objectives |= A.objectives
	objectives = owner.objectives - already_registered_objectives

//This one is created by admin tools for custom objectives
<<<<<<< HEAD:code/datums/antagonists/antag_datum.dm
/datum/antagonist/custom
=======
/datum/antagonist/custom
	antagpanel_category = "Custom"
	show_name_in_check_antagonists = TRUE //They're all different

/datum/antagonist/custom/admin_add(datum/mind/new_owner,mob/admin)
	var/custom_name = stripped_input(admin, "Custom antagonist name:", "Custom antag", "Antagonist")
	if(custom_name)
		name = custom_name
	else
		return
	..()
>>>>>>> 126a544... Slaughter demon, Morph, ERT / Deathsquad antag datums. (#35156):code/modules/antagonists/_common/antag_datum.dm
