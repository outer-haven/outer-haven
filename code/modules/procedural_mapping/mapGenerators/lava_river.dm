
/datum/mapGenerator/lavaland
<<<<<<< HEAD
	var/start_z = 5
=======
	var/start_z
>>>>>>> 827c4b3... Replace hardcoded z-level numbers with a trait system (#34090)
	var/min_x = 0
	var/min_y = 0
	var/max_x = 0
	var/max_y = 0
	modules = list(/datum/mapGeneratorModule/river)
	buildmode_name = "Pattern: Lava Rivers"

/datum/mapGenerator/lavaland/defineRegion(turf/Start, turf/End, replace = 0)
	start_z = Start.z
	min_x = min(Start.x,End.x)
	min_y = min(Start.y,End.y)
	max_x = max(Start.x,End.x)
	max_y = max(Start.y,End.y)
	..()

/datum/mapGeneratorModule/river
	var/river_type = /turf/open/lava/smooth
	var/river_nodes = 4
<<<<<<< HEAD
	var/start_z = 5
=======
>>>>>>> 827c4b3... Replace hardcoded z-level numbers with a trait system (#34090)

/datum/mapGeneratorModule/river/generate()
	var/datum/mapGenerator/lavaland/L = mother
	if(!istype(L))
		return
	spawn_rivers(L.start_z, river_nodes, river_type, min_x = L.min_x, min_y = L.min_y, max_x = L.max_x, max_y = L.max_y)
