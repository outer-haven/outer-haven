/*/////////////////////////////////////////////////////////////////////////
/////////////		The TRUE Energy Sword		///////////////////////////
*//////////////////////////////////////////////////////////////////////////

/obj/item/melee/transforming/energy/sword/cx
	name = "non-eutactic blade"
	desc = "The Non-Eutactic Blade utilizes a hardlight blade that is dynamically 'forged' on demand to create a deadly sharp edge that is unbreakable."
	icon_state = "cxsword_hilt"
	icon = 'haven/icons/eutactic/item/noneutactic.dmi'
	item_state = "cxsword"
	lefthand_file = 'haven/icons/eutactic/mob/noneutactic_left.dmi'
	righthand_file = 'haven/icons/eutactic/mob/noneutactic_right.dmi'
	force = 3
	throwforce = 5
	hitsound = "swing_hit" //it starts deactivated
	hitsound_on = 'haven/sound/weapons/nebhit.ogg'
	attack_verb_off = list("tapped", "poked")
	throw_speed = 3
	throw_range = 5
	sharpness = IS_SHARP
	embed_chance = 40
	embedded_impact_pain_multiplier = 10
	armour_penetration = 0
	block_chance = 60
	light_color = "#37FFF7"
	actions_types = list()

/obj/item/melee/transforming/energy/sword/cx/transform_weapon(mob/living/user, supress_message_text)
	active = !active				//I'd use a ..() here but it'd inherit from the regular esword's proc instead, so SPAGHETTI CODE
	if(active)						//also I'd need to rip out the iconstate changing bits
		force = force_on
		throwforce = throwforce_on
		hitsound = hitsound_on
		throw_speed = 4
		if(attack_verb_on.len)
			attack_verb = attack_verb_on
		w_class = w_class_on
		START_PROCESSING(SSobj, src)
		set_light(brightness_on)
		update_icon()
	else
		force = initial(force)
		throwforce = initial(throwforce)
		hitsound = initial(hitsound)
		throw_speed = initial(throw_speed)
		if(attack_verb_off.len)
			attack_verb = attack_verb_off
		w_class = initial(w_class)
		STOP_PROCESSING(SSobj, src)
		set_light(0)
		update_icon()
	transform_messages(user, supress_message_text)
	add_fingerprint(user)
	return TRUE

/obj/item/melee/transforming/energy/sword/cx/transform_messages(mob/living/user, supress_message_text)
	playsound(user, active ? 'haven/sound/weapons/nebon.ogg' : 'haven/sound/weapons/neboff.ogg', 65, 1)
	if(!supress_message_text)
		to_chat(user, "<span class='notice'>[src] [active ? "is now active":"can now be concealed"].</span>")

/obj/item/melee/transforming/energy/sword/cx/update_icon()
	var/mutable_appearance/blade_overlay = mutable_appearance('haven/icons/eutactic/item/noneutactic.dmi', "cxsword_blade")
	var/mutable_appearance/gem_overlay = mutable_appearance('haven/icons/eutactic/item/noneutactic.dmi', "cxsword_gem")

	if(light_color)
		blade_overlay.color = light_color
		gem_overlay.color = light_color

	cut_overlays()		//So that it doesn't keep stacking overlays non-stop on top of each other

	add_overlay(gem_overlay)

	if(active)
		add_overlay(blade_overlay)
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_hands()

/obj/item/melee/transforming/energy/sword/cx/AltClick(mob/living/user)
	if(!in_range(src, user))	//Basic checks to prevent abuse
		return
	if(user.incapacitated() || !istype(user))
		to_chat(user, "<span class='warning'>You can't do that right now!</span>")
		return

	if(alert("Are you sure you want to recolor your blade?", "Confirm Repaint", "Yes", "No") == "Yes")
		var/energy_color_input = input(usr,"Choose Energy Color") as color|null
		if(energy_color_input)
			light_color = sanitize_hexcolor(energy_color_input, desired_format=6, include_crunch=1)
		update_icon()
		update_light()

/obj/item/melee/transforming/energy/sword/cx/examine(mob/user)
	..()
	to_chat(user, "<span class='notice'>Alt-click to recolor it.</span>")

/obj/item/melee/transforming/energy/sword/cx/worn_overlays(isinhands, icon_file)
	. = ..()
	if(active)
		if(isinhands)
			var/mutable_appearance/blade_inhand = mutable_appearance(icon_file, "cxsword_blade")
			blade_inhand.color = light_color
			. += blade_inhand

//OBLIGATORY TOY MEMES	/////////////////////////////////////

/obj/item/toy/sword/cx
	name = "\improper DX Non-Euplastic LightSword"
	desc = "A deluxe toy replica of an energy sword. Realistic visuals and sounds! Ages 8 and up."
	icon = 'haven/icons/eutactic/item/noneutactic.dmi'
	icon_state = "cxsword_hilt"
	item_state = "cxsword"
	lefthand_file = 'haven/icons/eutactic/mob/noneutactic_left.dmi'
	righthand_file = 'haven/icons/eutactic/mob/noneutactic_right.dmi'
	active = FALSE
	w_class = WEIGHT_CLASS_SMALL
	attack_verb = list("poked", "jabbed", "hit")
	light_color = "#37FFF7"
	var/light_brightness = 3
	actions_types = list()

/obj/item/toy/sword/cx/attack_self(mob/user)
	active = !( active )

	if (active)
		to_chat(user, "<span class='notice'>You activate the holographic blade with a press of a button.</span>")
		playsound(user, 'haven/sound/weapons/nebon.ogg', 50, 1)
		w_class = WEIGHT_CLASS_BULKY
		attack_verb = list("slashed", "stabbed", "ravaged")
		set_light(light_brightness)
		update_icon()

	else
		to_chat(user, "<span class='notice'>You deactivate the holographic blade with a press of a button.</span>")
		playsound(user, 'haven/sound/weapons/neboff.ogg', 50, 1)
		w_class = WEIGHT_CLASS_SMALL
		attack_verb = list("poked", "jabbed", "hit")
		set_light(0)
		update_icon()

	add_fingerprint(user)

/obj/item/toy/sword/cx/update_icon()
	var/mutable_appearance/blade_overlay = mutable_appearance('haven/icons/eutactic/item/noneutactic.dmi', "cxsword_blade")
	var/mutable_appearance/gem_overlay = mutable_appearance('haven/icons/eutactic/item/noneutactic.dmi', "cxsword_gem")

	if(light_color)
		blade_overlay.color = light_color
		gem_overlay.color = light_color

	cut_overlays()		//So that it doesn't keep stacking overlays non-stop on top of each other

	add_overlay(gem_overlay)

	if(active)
		add_overlay(blade_overlay)
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_hands()

/obj/item/toy/sword/cx/AltClick(mob/living/user)
	if(!in_range(src, user))	//Basic checks to prevent abuse
		return
	if(user.incapacitated() || !istype(user))
		to_chat(user, "<span class='warning'>You can't do that right now!</span>")
		return

	if(alert("Are you sure you want to recolor your blade?", "Confirm Repaint", "Yes", "No") == "Yes")
		var/energy_color_input = input(usr,"Choose Energy Color") as color|null
		if(energy_color_input)
			light_color = sanitize_hexcolor(energy_color_input, desired_format=6, include_crunch=1)
		update_icon()
		update_light()

/obj/item/toy/sword/cx/worn_overlays(isinhands, icon_file)
	. = ..()
	if(active)
		if(isinhands)
			var/mutable_appearance/blade_inhand = mutable_appearance(icon_file, "cxsword_blade")
			blade_inhand.color = light_color
			. += blade_inhand

/obj/item/toy/sword/cx/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/toy/sword/cx))
		if((W.flags_1 & NODROP_1) || (flags_1 & NODROP_1))
			to_chat(user, "<span class='warning'>\the [flags_1 & NODROP_1 ? src : W] is stuck to your hand, you can't attach it to \the [flags_1 & NODROP_1 ? W : src]!</span>")
			return
		else
			to_chat(user, "<span class='notice'>You combine the two plastic swords, making a single supermassive toy! You're fake-cool.</span>")
			new /obj/item/twohanded/hypereutactic/toy(user.loc)
			qdel(W)
			qdel(src)
	else
		return ..()

/obj/item/toy/sword/cx/examine(mob/user)
	..()
	to_chat(user, "<span class='notice'>Alt-click to recolor it.</span>")

/////////////////////////////////////////////////////
//	HYPEREUTACTIC Blades	/////////////////////////
/////////////////////////////////////////////////////

/obj/item/twohanded/hypereutactic
	icon = 'haven/icons/eutactic/item/hypereutactic.dmi'
	icon_state = "hypereutactic"
	lefthand_file = 'haven/icons/eutactic/mob/hypereutactic_left.dmi'
	righthand_file = 'haven/icons/eutactic/mob/hypereutactic_right.dmi'
	item_state = "hypereutactic"
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	name = "hypereutactic blade"
	desc = "A supermassive weapon envisioned to cleave the very fabric of space and time itself in twain, the hypereutactic blade dynamically flash-forges a hypereutactic crystaline nanostructure capable of passing through most known forms of matter like a hot knife through butter."
	force = 3
	throwforce = 5
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	var/w_class_on = WEIGHT_CLASS_BULKY
	force_unwielded = 3
	force_wielded = 40
	wieldsound = 'haven/sound/weapons/nebon.ogg'
	unwieldsound = 'haven/sound/weapons/neboff.ogg'
	hitsound = "swing_hit"
	armour_penetration = 40
	light_color = "#37FFF7"
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "destroyed", "ripped", "devastated", "shredded")
	block_chance = 75
	max_integrity = 200
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0, fire = 100, acid = 70)
	resistance_flags = FIRE_PROOF
	var/brightness_on = 6 //TWICE AS BRIGHT AS A REGULAR ESWORD
	flags_2 = SLOWS_WHILE_IN_HAND_2

/obj/item/twohanded/hypereutactic/wield(mob/living/carbon/M) //Specific wield () hulk checks due to reflection chance for balance issues and switches hitsounds.
	if(M.has_dna())
		if(M.dna.check_mutation(HULK))
			to_chat(M, "<span class='warning'>You lack the grace to wield this!</span>")
			return
	..()
	if(wielded)
		sharpness = IS_SHARP
		w_class = w_class_on
		hitsound = 'haven/sound/weapons/nebhit.ogg'
		START_PROCESSING(SSobj, src)
		set_light(brightness_on)
		slowdown = 1

/obj/item/twohanded/hypereutactic/unwield() //Specific unwield () to switch hitsounds.
	sharpness = initial(sharpness)
	w_class = initial(w_class)
	..()
	hitsound = "swing_hit"
	STOP_PROCESSING(SSobj, src)
	set_light(0)
	slowdown = initial(slowdown)

/obj/item/twohanded/hypereutactic/update_icon()
	var/mutable_appearance/blade_overlay = mutable_appearance('haven/icons/eutactic/item/hypereutactic.dmi', "hypereutactic_blade")
	var/mutable_appearance/gem_overlay = mutable_appearance('haven/icons/eutactic/item/hypereutactic.dmi', "hypereutactic_gem")

	if(light_color)
		blade_overlay.color = light_color
		gem_overlay.color = light_color

	cut_overlays()		//So that it doesn't keep stacking overlays non-stop on top of each other

	add_overlay(gem_overlay)

	if(wielded)
		add_overlay(blade_overlay)
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_hands()

	SendSignal(COMSIG_COMPONENT_CLEAN_ACT, CLEAN_STRENGTH_BLOOD)

/obj/item/twohanded/hypereutactic/AltClick(mob/living/user)
	if(!in_range(src, user))	//Basic checks to prevent abuse
		return
	if(user.incapacitated() || !istype(user))
		to_chat(user, "<span class='warning'>You can't do that right now!</span>")
		return

	if(alert("Are you sure you want to recolor your blade?", "Confirm Repaint", "Yes", "No") == "Yes")
		var/energy_color_input = input(usr,"Choose Energy Color") as color|null
		if(energy_color_input)
			light_color = sanitize_hexcolor(energy_color_input, desired_format=6, include_crunch=1)
		update_icon()
		update_light()

/obj/item/twohanded/hypereutactic/worn_overlays(isinhands, icon_file)
	. = ..()
	if(isinhands)
		var/mutable_appearance/gem_inhand = mutable_appearance(icon_file, "hypereutactic_gem")
		gem_inhand.color = light_color
		. += gem_inhand
		if(wielded)
			var/mutable_appearance/blade_inhand = mutable_appearance(icon_file, "hypereutactic_blade")
			blade_inhand.color = light_color
			. += blade_inhand

/obj/item/twohanded/hypereutactic/examine(mob/user)
	..()
	to_chat(user, "<span class='notice'>Alt-click to recolor it.</span>")



////////// stuff beneath this is all taken from the desword ////////////  wow very professional such OOP wow



/obj/item/twohanded/hypereutactic/attack(mob/target, mob/living/carbon/human/user)
	if(user.has_dna())
		if(user.dna.check_mutation(HULK))
			to_chat(user, "<span class='warning'>You grip the blade too hard and accidentally close it!</span>")
			unwield()
			return
	..()
	if(user.has_disability(DISABILITY_CLUMSY) && (wielded) && prob(40))
		impale(user)
		return

/obj/item/twohanded/hypereutactic/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/twohanded/hypereutactic/proc/impale(mob/living/user)
	to_chat(user, "<span class='warning'>You spin around a bit before losing your balance and impaling yourself on [src].</span>")
	if (force_wielded)
		user.take_bodypart_damage(20,25)
	else
		user.adjustStaminaLoss(25)

/obj/item/twohanded/hypereutactic/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	if(wielded)
		return ..()
	return FALSE

/obj/item/twohanded/hypereutactic/attack_hulk(mob/living/carbon/human/user, does_attack_animation = 0)  //In case thats just so happens that it is still activated on the groud, prevents hulk from picking it up
	if(wielded)
		to_chat(user, "<span class='warning'>You can't pick up such dangerous item with your meaty hands without losing fingers, better not to!</span>")
		return TRUE

/obj/item/twohanded/hypereutactic/process()
	if(wielded)
		open_flame()
	else
		STOP_PROCESSING(SSobj, src)

/obj/item/twohanded/hypereutactic/IsReflect()
	if(wielded)
		return TRUE

/obj/item/twohanded/hypereutactic/ignition_effect(atom/A, mob/user)
	// same as /obj/item/melee/transforming/energy, mostly
	if(!wielded)
		return ""
	var/in_mouth = ""
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(C.wear_mask == src)
			in_mouth = ", barely missing their nose"
	. = "<span class='warning'>[user] swings [user.p_their()] [src][in_mouth]. [user.p_they()] light[user.p_s()] [A] in the process.</span>"
	playsound(loc, hitsound, get_clamped_volume(), 1, -1)
	add_fingerprint(user)

//////////////////	TOY VERSION	/////////////////////////////

/obj/item/twohanded/hypereutactic/toy
	name = "\improper DX Hyper-Euplastic LightSword"
	desc = "A supermassive toy envisioned to cleave the very fabric of space and time itself in twain. Realistic visuals and sounds! Ages 8 and up."
	force = 0
	throwforce = 0
	throw_speed = 3
	throw_range = 5
	force_unwielded = 0
	force_wielded = 0
	attack_verb = list("attacked", "struck", "hit")

/obj/item/twohanded/hypereutactic/toy/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	return FALSE

/obj/item/twohanded/hypereutactic/toy/IsReflect()//Stops it from reflecting energy projectiles
	return FALSE
