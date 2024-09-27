function hit(shooterId, targetId, damage, weaponId, hitLocation, matchId)
    local weapons = {
        "WEAPON_GRENADELAUNCHER",
        "WEAPON_RPG",
        "WEAPON_STINGER",
        "WEAPON_MINIGUN",
        "WEAPON_GRENADE",
        "WEAPON_STICKYBOMB",
        "WEAPON_FIREWORK",
        "WEAPON_RAILGUN",
        "WEAPON_AUTOSHOTGUN",
        "WEAPON_COMPACTLAUNCHER",
        "WEAPON_PIPEBOMB",
        "WEAPON_HAMMER",
        "WEAPON_HEAVYSNIPER",
        "WEAPON_BAT",
        "WEAPON_GOLFCLUB",
        "WEAPON_CROWBAR",
        "WEAPON_BOTTLE",
        "WEAPON_DAGGER",
        "WEAPON_HATCHET",
        "WEAPON_MACHETE",
        "WEAPON_PROXMINE",
        "WEAPON_BZGAS",
        "WEAPON_MOLOTOV",
        "WEAPON_FIREEXTINGUISHER",
        "WEAPON_SNOWBALL",
        "WEAPON_FLARE",
        "WEAPON_BALL",
        "WEAPON_POOLCUE",
        "WEAPON_PIPEWRENCH",
        "WEAPON_PISTOL_MK2",
        "WEAPON_APPISTOL",
        "WEAPON_SNSPISTOL",
        "WEAPON_HEAVYPISTOL",
        "WEAPON_FLAREGUN",
        "WEAPON_MARKSMANPISTOL",
        "WEAPON_MARKSMANPISTOL",
        "WEAPON_SMG_MK2",
        "WEAPON_SMG",
        "WEAPON_ASSAULTSMG",
        "WEAPON_MG",
        "WEAPON_COMBATMG",
        "WEAPON_COMBATMG_MK2",
        "WEAPON_ASSAULTSMG",
        "WEAPON_COMBATPDW",
        "WEAPON_GUSENBERG",
        "WEAPON_MACHINEPISTOL",
        "WEAPON_ASSAULTRIFLE_MK2",
        "WEAPON_CARBINERIFLE_MK2",
        "WEAPON_ADVANCEDRIFLE",
        "WEAPON_SPECIALCARBINE",
        "WEAPON_BULLPUPRIFLE",
        "WEAPON_COMPACTRIFLE",
        "WEAPON_SWEEPERSHOTGUN",
        "WEAPON_SAWNOFFSHOTGUN",
        "WEAPON_BULLPUPSHOTGUN",
        "WEAPON_ASSAULTSHOTGUN",
        "WEAPON_MUSKET",
        "WEAPON_HEAVYSHOTGUN",
        "WEAPON_DBSHOTGUN",
        "WEAPON_HEAVYSNIPER_MK2",
        "WEAPON_MARKSMANRIFLE",
        "WEAPON_GRENADELAUNCHER",
        "WEAPON_GRENADELAUNCHER_SMOKE",
        "WEAPON_FIREWORK",
        "WEAPON_RAILGUN",
        "WEAPON_HOMINGLAUNCHER",
        "WEAPON_COMPACTLAUNCHER",
        "WEAPON_SNSPISTOL_MK2",
        "WEAPON_REVOLVER_MK2",
        "WEAPON_DOUBLEACTION",
        "WEAPON_SPECIALCARBINE_MK2",
        "WEAPON_BULLPUPRIFLE_MK2",
        "WEAPON_PUMPSHOTGUN_MK2",
        "WEAPON_MARKSMANRIFLE_MK2",
        "WEAPON_RAYPISTOL",
        "WEAPON_RAYCARBINE",
        "WEAPON_RAYMINIGUN",
        "WEAPON_DIGISCANNER",
        "WEAPON_KNIFE",
        "WEAPON_BATTLEAXE",
        "WEAPON_SWITCHBLADE",
        "WEAPON_WRENCH",
        "WEAPON_KNUCKLE",
        "WEAPON_FLASHLIGHT",
        "WEAPON_NIGHTSTICK",
        "WEAPON_PISTOL",
        "WEAPON_MICROSMG",
        "WEAPON_MINISMG",
        "WEAPON_VINTAGEPISTOL",
        "WEAPON_PISTOL50",
        "WEAPON_REVOLVER",
        "WEAPON_COMBATPISTOL",
        "WEAPON_CARBINERIFLE",
        "WEAPON_PUMPSHOTGUN",
        "WEAPON_ASSAULTRIFLE",
        "GADGET_PARACHUTE",
        "WEAPON_STUNGUN",
        "WEAPON_SNIPERRIFLE",
        "WEAPON_PETROLCAN"
    }
    local roundData = Games.data[matchId].rounds.data[Games.data[matchId].rounds.current] or {hits={}}
    roundData.hits = roundData.hits or {}
    Games.data[matchId].rounds.data[Games.data[matchId].rounds.current] = roundData
    table.insert(roundData.hits, {
        shooterId = shooterId,
        targetId = targetId,
        damage = damage,
        weapon = weapons[weaponId],
        location = hitLocation
    })
    print("Hit registrado:", shooterId, "->", targetId, "Dano:", damage)
end

Games = {}

Games.data = {
    ['matchmaking-01'] = {
        players = {
            data = {
                attackers = {
                    [10] = {
                        nick = 'MidnightWolf',
                        group = 'group:10',
                        leader = true
                    },
                    [2] = {
                        nick = 'BlazeGamer',
                        group = 'group:4',
                        leader = false
                    },
                    [3] = {
                        nick = 'SpeedRacer',
                        group = 'group:4',
                        leader = false
                    },
                    [4] = {
                        nick = 'ShadowNinja',
                        group = 'group:4',
                        leader = true
                    },
                    [5] = {
                        nick = 'PhoenixFire',
                        group = 'group:4',
                        leader = false
                    }
                },
                defenders = {
                    [6] = {
                        nick = 'ThunderBolt',
                        group = 'group:6',
                        leader = true
                    },
                    [7] = {
                        nick = 'GhostRider',
                        group = 'group:6',
                        leader = false
                    },
                    [8] = {
                        nick = 'NeonSpectre',
                        group = 'group:9',
                        leader = false
                    },
                    [9] = {
                        nick = 'DriftKing',
                        group = 'group:9',
                        leader = true
                    },
                    [1] = {
                        nick = 'ViperGT',
                        group = 'group:1',
                        leader = true
                    }
                }
            }
        },
        rounds = {
            current = 1,
            data = {
                [1] = {
                    -- Dados da rodada serão inseridos aqui.
                }
            }
        }
    }
}

function ShowCombatStats(playerId, matchId)
    local match = Games.data[matchId]
    local players = match.players.data
    local currentRound = match.rounds.current
    local roundData = match.rounds.data[currentRound]
    if not roundData or not roundData.hits then return end

    local playersStats = {}

    for _, hit in ipairs(roundData.hits) do
        local refId, direction = nil, nil
        if hit.shooterId == playerId then
            refId, direction = hit.targetId, 'outgoing'
        elseif hit.targetId == playerId then
            refId, direction = hit.shooterId, 'incoming'
        end

        if refId then
            local player = players.attackers[refId] or players.defenders[refId]
            playersStats[refId] = playersStats[refId] or { nick = player.nick, outgoing = 0, incoming = 0, hits = { 
                outgoing = {0,0,0}, 
                incoming = {0,0,0} } 
            }

            playersStats[refId].hits[direction][hit.location] = playersStats[refId].hits[direction][hit.location] + 1
            playersStats[refId][direction] = playersStats[refId][direction] + hit.damage
            playersStats[refId].weapon = hit.weapon -- last damage
        end
    end

    local left, center, right = 0.84, 0.9, 0.96
    local y = 0.4

    DrawRect(center, y-0.04, 0.2, 0.05, 0, 0, 0, 145)
    DrawTextUI("Outgoing", left, 0.355, 0.3)
    DrawTextUI("Combat Report", center, 0.35, 0.45)
    DrawTextUI("Incoming", right, 0.355, 0.3)
    local bones = { " head", "chest", "  legs" }
    for _, ply in pairs(playersStats) do
        DrawTextUI(tostring(ply.outgoing), left - 0.01, y-0.004, 0.4)
        for i, hit in ipairs(ply.hits.outgoing) do
            DrawTextUI(hit.." - "..bones[i], left + 0.01, y + (i-2) * (0.015), 0.25)
        end
        DrawTextUI(ply.nick, center, y-0.015, 0.36)
        DrawTextUI(ply.weapon, center, y+0.005, 0.34)
        DrawTextUI(tostring(ply.incoming), right - 0.01, y-0.004, 0.4)
        for i, hit in ipairs(ply.hits.incoming) do
            DrawTextUI(hit.." - "..bones[i], right+0.01, y + (i-2) * (0.015), 0.25)
        end
        DrawRect(center, y+0.01, 0.2, 0.05, 0, 0, 0, 145)
        y = y + 0.05
    end
end

function DrawTextUI(text, x, y, scale)
    SetTextFont(4)
    SetTextCentre(true)
    SetTextScale(scale or 0.35, scale or 0.35)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextJustification(0)
    AddTextComponentString(text)
    DrawText(x, y)
end


CreateThread(function()
    while true do
        local sleep = 0
        ShowCombatStats(10, "matchmaking-01") -- Mostra as estatísticas do jogador 10
        Wait(sleep)
    end
end)

-- Teste de hit
CreateThread(function()
    hit(10, 6, 150, 95, 1, 'matchmaking-01')
    hit(6, 10, 40, 95, 2, 'matchmaking-01')
    hit(1, 10, 90, 95, 3, 'matchmaking-01')
    -- hit(10, 7, 150, "AK-47", 1, 'matchmaking-01')
    -- hit(10, 8, 150, "AK-47", 1, 'matchmaking-01')
    hit(10, 9, 150, 95, 1, 'matchmaking-01')

end)