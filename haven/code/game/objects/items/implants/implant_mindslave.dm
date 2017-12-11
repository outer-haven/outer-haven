/obj/item/implant/mindslave
	name = "mindslave implant"
	desc = "Turn a crewmate into your eternal slave"
	activated = 0
	implant_time = 300

/obj/item/implant/mindslave/get_data()
	var/dat = {"
<b>Implant Specifications:</b><BR>
<b>Name:</b> Syndicate Loyalty Implant<BR>
<b>Life:</b> Single use<BR>
<b>Important Notes:</b> <font color='red'>Illegal</font><BR>
<HR>
<b>Implant Details:</b> <BR>
<b>Function:</b> Makes the injected a slave to the owner of the implant.<HR>"}
	return dat

/obj/item/implant/mindslave/implant(mob/source, var/mob/user)

	if(!source.mind)
		to_chat(user.mind, "<span class='notice'>[source] doesn't posses the mental capabilities to be a slave.</span>")
		return 0

	var/mob/living/carbon/human/target = source.mind.current
	var/mob/living/carbon/human/holder = user.mind.current

	if(target == holder)
		to_chat(holder, "<span class='notice'>You can't implant yourself!</span>")
		return 0

	var/obj/item/implant/mindslave/imp = locate(src.type) in source
	if(imp)
		to_chat(holder, "<span class='warning'>[target] is already a slave!</span>")
		return 0

	if(target.isloyal())
		to_chat(holder, "<span class='warning'>[target] seems to resist the implant!</span>")
		return 0

	to_chat(target, "<span class='userdanger'><FONT size = 3>You feel a strange urge to serve [holder.real_name]. A simple thought about disobeying his/her commands makes your head feel like it is going to explode. You feel like you dont want to know what will happen if you actually disobey your new master.</FONT></span>")

	var/datum/objective/mindslave/serve_objective = new
	serve_objective.owner = target
	serve_objective.explanation_text = "Serve [holder.real_name] no matter what!"
	serve_objective.completed = 1
	source.mind.objectives += serve_objective
	if(!SSticker.mode.traitors.Find(source.mind))
		SSticker.mode.traitors += source.mind

	log_game("[holder.ckey] enslaved [target.ckey] with a Mindslave implant")

	return ..()

/obj/item/implant/mindslave/removed(mob/target)
	if(..())

		for(var/datum/objective/mindslave/objective in target.mind.objectives)
			target.mind.objectives -= objective

		if(target.mind.objectives.len == 0)
			SSticker.mode.traitors -= target.mind

		if(target.stat != DEAD)
			target.visible_message("<span class='notice'>[target] looks like they have just been released from slavery!</span>", "<span class='boldnotice'>You feel as if you have just been released from eternal slavery. Yet you cant seem to remember anything at all!</span>")
		return 1

/obj/item/implanter/mindslave
	name = "implanter (freedom)"

/obj/item/implanter/mindslave/New()
	imp = new /obj/item/implant/mindslave(src)
	..()

/datum/objective/mindslave
	martyr_compatible = 1
