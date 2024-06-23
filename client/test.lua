RegisterCommand('object_gizmo',function(source, args, rawCommand) --example of how the gizmo could be used /spawnobject {object model name}
    local object = tonumber(args[1])
    if object then 
        local playerPed = PlayerPedId()
        local offset = GetOffsetFromEntityInWorldCoords(playerPed, 0, 1.0, 0)

        local objectPositionData = exports.object_gizmo:useGizmo(object) --export for the gizmo. just pass an object handle to the function.
        
        print(json.encode(objectPositionData, { indent = true }))
    end
end)
