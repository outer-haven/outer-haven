// HAVEN start - replaces the jumpsuit contents of the mixed wardrobe with polychromic samplers

/obj/structure/closet/wardrobe/mixed/PopulateContents()
	if(prob(40))
		new /obj/item/clothing/suit/jacket(src)
	if(prob(40))
		new /obj/item/clothing/suit/jacket(src)
	new /obj/item/clothing/under/polychromic/jumpsuit(src)
	new /obj/item/clothing/under/polychromic/jumpsuit(src)
	new /obj/item/clothing/under/polychromic/jumpsuit(src)
	new /obj/item/clothing/under/polychromic/shirt(src)
	new /obj/item/clothing/under/polychromic/shirt(src)
	new /obj/item/clothing/under/polychromic/shirt(src)
	new /obj/item/clothing/under/polychromic/kilt(src)
	new /obj/item/clothing/under/polychromic/kilt(src)
	new /obj/item/clothing/under/polychromic/kilt(src)
	new /obj/item/clothing/under/polychromic/skirt(src)
	new /obj/item/clothing/under/polychromic/skirt(src)
	new /obj/item/clothing/under/polychromic/skirt(src)
	new /obj/item/clothing/under/polychromic/shorts(src)
	new /obj/item/clothing/under/polychromic/shorts(src)
	new /obj/item/clothing/under/polychromic/shorts(src)
	new /obj/item/clothing/mask/bandana/red(src)
	new /obj/item/clothing/mask/bandana/red(src)
	new /obj/item/clothing/mask/bandana/blue(src)
	new /obj/item/clothing/mask/bandana/blue(src)
	new /obj/item/clothing/mask/bandana/gold(src)
	new /obj/item/clothing/mask/bandana/gold(src)
	new /obj/item/clothing/shoes/sneakers/black(src)
	new /obj/item/clothing/shoes/sneakers/brown(src)
	new /obj/item/clothing/shoes/sneakers/white(src)
	if(prob(30))
		new /obj/item/clothing/suit/hooded/wintercoat(src)
		new /obj/item/clothing/shoes/winterboots(src)
	return

// HAVEN end