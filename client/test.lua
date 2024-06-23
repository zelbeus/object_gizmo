RegisterCommand('object_gizmo',function(source, args, rawCommand) --example of how the gizmo could be used /object_gizmo {object entity id}
    local object = tonumber(args[1])
    if object then 
        local playerPed = PlayerPedId()
        local offset = GetOffsetFromEntityInWorldCoords(playerPed, 0, 1.0, 0)

        local objectPositionData = exports.object_gizmo:useGizmo(object) --export for the gizmo. just pass an object handle to the function.
        
        print(json.encode(objectPositionData, { indent = true }))
    end
end)

RegisterCommand('spawnobject',function(source, args, rawCommand) --example of how the gizmo could be used /spawnobject {object model name}
    local objectName = args[1] or "prop_bench_01a"
    local playerPed = PlayerPedId()
    local offset = GetOffsetFromEntityInWorldCoords(playerPed, 0, 1.0, 0)

    local model = GetHashKey(objectName)
    RequestModel(model)
    while not HasModelLoaded(model) do 
        Wait(0)
    end

    local object = CreateObject(model, offset.x, offset.y, offset.z, true, false, false)
    SetModelAsNoLongerNeeded(model)
    local objectPositionData = exports.object_gizmo:useGizmo(object) --export for the gizmo. just pass an object handle to the function.
    print(json.encode(objectPositionData, { indent = true }))
    
end)
