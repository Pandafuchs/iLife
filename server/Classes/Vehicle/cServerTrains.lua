--
-- Created by IntelliJ IDEA.
-- User: Noneatme, Jusonex
-- Date: 29.01.2015
-- Time: 18:21
-- To change this template use File | Settings | File Templates.
--

local train     = {}

ServerTrains = {}
ServerTrains.Settings =
{
    Interval = 1000;
    TrackFiles = {"res/traintracks/tracks.dat", --[["res/traintracks/tracks2.dat", "res/traintracks/tracks3.dat", "res/traintracks/tracks4.dat"]]};
}

function ServerTrains:new(...) local o = setmetatable({}, {__index = ServerTrains}) o:constructor(...) return o end
function ServerTrains:constructor()
    self.m_Tracks = {}

    -- Sehr Langsam(Haltestellen)
    self.m_verySlowPositions    =
    {
        ["cranberry station"]   = true,
        ["unity station"]       = true,
        ["linden station"]      = true,
        ["sobell rail yards"]   = true,
        ["yellow bell station"] = true,

        ["market station"]      = true,
    }

    -- Langsam
    self.m_slowPositions    =
    {
        ["el corona"]       = true,
        ["jefferson"]       = true,
        ["east los santos"] = true,
        ["idlewood"]        = true,
        ["willowfield"]     = true,

        -- New --
        ["doherty"]         = true,
        ["prickle pine"]    = true,
        ["linden side"]     = true,

        ["verdant bluffs"]  = true,

    }
    -- Normal
    -- Alles Andere

    -- Very Fast
    self.m_veryFastPositions    =
    {
        ["richman"]                 = true,
        ["los santos"]              = true, -- Lo
        -- s Santos nicht ganz, nur die orte wo keine Name vorhanden ist
        ["whetstone"]               = true,
        ["easter basin"]            = true,
        ["san fierro"]              = true,
        ["las venturas"]            = true,
        ["kincaid bridge"]          = true,
        ["tierra robada"]           = true,
        ["bone county"]             = true,
        ["lil' probe inn"]          = true,
        ["frederick bridge"]        = true,

    }
    -- Load tracks
    for k, v in ipairs(self.Settings.TrackFiles) do
        local file = fileOpen(v, true)
        local content = fileRead(file, fileGetSize(file))
        local lines = split(content, "\r\n")

        self.m_Tracks[k] = {}
        for i, j in ipairs(lines) do
            if i ~= 1 then -- Ignore first line (contains number of track nodes)
            local x, y, z = unpack(split(j, " "))
            table.insert(self.m_Tracks[k], {index = i-1, x = x, y = y, z = z})
            end
        end
    end

    -- Calculate distances
    for trackId, trackData in ipairs(self.m_Tracks) do
        local lastDistance = 0
        for k, node in ipairs(trackData) do
            local previousPosition = trackData[k-1] or {x = 0, y = 0, z = 0}
            lastDistance = lastDistance + getDistanceBetweenPoints3D(node.x, node.y, node.z, previousPosition.x, previousPosition.y, previousPosition.z)
            node.distance = lastDistance
        end
    end

    -- Initialize train list
    self.m_Trains = {}

    -- Start position updating timer
    setTimer(function() self:updateTrains() end, self.Settings.Interval, -1)

    -- Add some events
    --[[addEvent("trainStreamIn", true)
    addEventHandler("trainStreamIn", root,
        function(x, y, z)
            if not getElementSyncer(source) then
                --outputDebugString("New syncer found!")
                setElementSyncer(source, client)
                setElementPosition(source, x, y, z)
            end
        end
    )]]
end

function ServerTrains:addTrain(train2, speed)
    self.m_Trains[train2] = {speed = speed, node = false, track = false, trackDistance = 0}

    setElementData(train2, "IsServerTrain", true)
    setTrainDerailable(train2, false)
    -- Disable sync
    addEventHandler("onElementStartSync", train2,
        function(asdf)
            for index, bla in pairs(train) do
                setElementSyncer(train[index], asdf)
            end
        end
    )

end

function ServerTrains:updateTrains()
    for train, info in pairs(self.m_Trains) do
        if not info.node then
            info.node, info.track = self:getClosestNodeToPoint(getElementPosition(train))
         --   outputDebugString(("Found new track + node. Node: %d Track: %d"):format(info.node.index, info.track))
            info.trackDistance = info.node.distance
        end

        local nextNode = self.m_Tracks[info.track][info.node.index + 1] or self.m_Tracks[info.track][1]
        local deltaTrackDistance = info.speed * 50 * self.Settings.Interval / 1000

        info.trackDistance = info.trackDistance + deltaTrackDistance
        while info.trackDistance > nextNode.distance do
            info.node = nextNode
            nextNode = self.m_Tracks[info.track][nextNode.index+1]

            if not nextNode then
                nextNode = self.m_Tracks[info.track][2]
                info.node = self.m_Tracks[info.track][1]
                info.trackDistance = info.node.distance
                break
            end
        end

        local deltaNodes = getDistanceBetweenPoints3D(info.node.x, info.node.y, info.node.z, nextNode.x, nextNode.y, nextNode.z)
        local progress = (info.trackDistance - info.node.distance) / deltaNodes

        -- Interpolate and set the position
        local x, y, z = interpolateBetween(info.node.x, info.node.y, info.node.z, nextNode.x, nextNode.y, nextNode.z, progress, "Linear")
        local x2, y2, z2    = getElementPosition(train);
        local zone          = getZoneName(x2, y2, z2, false)
        if(self.m_slowPositions[string.lower(zone)]) then
            self.m_Trains[train].speed = 0.4;
        elseif(self.m_verySlowPositions[string.lower(zone)]) then
            self.m_Trains[train].speed = 0.15;
        elseif(self.m_veryFastPositions[string.lower(zone)]) then
            self.m_Trains[train].speed = 1.1;
        else
            self.m_Trains[train].speed = 0.8;
        end

    --    outputDebugString(("Position: X=%.2f Y=%.2f Z=%.2f Node=%d Distance=%.4f Syncer=%s"):format(x, y, z, info.node.index, info.trackDistance, getElementSyncer(train) and getPlayerName(getElementSyncer(train)) or "false"))

   --     setElementPosition(train, x, y, z)
        triggerClientEvent("trainSyncPulse", train, x, y, z, info.speed)

    end
end

function ServerTrains:getClosestNodeToPoint(x, y, z)
    local minDistance = math.huge
    local closestNode, closestTrack

    -- Iterate over train tracks
    for i, trackNodes in ipairs(self.m_Tracks) do

        -- Iterate over track nodes
        for k, node in ipairs(trackNodes) do
            local distance = getDistanceBetweenPoints3D(x, y, z, node.x, node.y, node.z)
            if distance < minDistance then
                minDistance = distance
                closestNode = node
                closestTrack = i
            end
        end
    end

    return closestNode, closestTrack
end


addEventHandler("onResourceStart", resourceRoot,
function()
    local x, y, z = 2766.4509277344, 305.17666625977, 8.2681865692139

    local trails =
        {
            537,
            569,
            569,
            590,
            590,
            590,
            569,
            569,
            569,
            569,
            569,
            590,
            590,
            569,
            569,
        }

        local curAdd    = 50;
        local serverTrains = ServerTrains:new()


        for index, id in ipairs(trails) do
            setTimer(function()
                train[index] = createVehicle(id, x, y, z);
                setVehicleLocked(train[index], true)
                setTrainDerailable(train[index], false)
                setTrainDirection(train[index], true)
                setElementID(train[index], "train")

                if(train[index-1]) and (isElement(train[index-1])) then
                    attachTrailerToVehicle(train[index-1], train[index])
                else
                    local ped = createPed(60, x, y, z)
                    warpPedIntoVehicle(ped, train[index]);
                    serverTrains:addTrain(train[index], -0.5)


                end
            end, curAdd*index, 1)
        end
    end
)
