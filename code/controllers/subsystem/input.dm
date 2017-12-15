SUBSYSTEM_DEF(input)
	name = "Input"
	wait = 1 //SS_TICKER means this runs every tick
<<<<<<< HEAD
	flags = SS_TICKER | SS_NO_INIT | SS_KEEP_TIMING
	priority = 151
=======
	flags = SS_TICKER | SS_NO_INIT
	priority = FIRE_PRIORITY_INPUT
>>>>>>> 0244b61... Merge pull request #33537 from ninjanomnom/priority-defines
	runlevels = RUNLEVELS_DEFAULT | RUNLEVEL_LOBBY

/datum/controller/subsystem/input/fire()
	var/list/clients = GLOB.clients // Let's sing the list cache song
	for(var/i in 1 to clients.len)
		var/client/C = clients[i]
		C.keyLoop()