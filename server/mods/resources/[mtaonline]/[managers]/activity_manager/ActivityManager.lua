ActivityManager = {
    activities = {}
}

function ActivityManager.Start()
    log("Starting up")
    log("Started")
end

function ActivityManager.Stop()
    log("Stopping")
    log("Stopped")
end

function ActivityManager.Restart()
    log("Restarting")
    ActivityManager.Stop()
    ActivityManager.Start()
    log("Restarted")
end

addEventHandler("onResourceStart",resourceRoot,ActivityManager.Start)
addEventHandler("onResourceStop",resourceRoot,ActivityManager.Stop)
