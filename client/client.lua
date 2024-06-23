local usingGizmo = false
local gizmoText = ""
local function toggleNuiFrame(bool)
    usingGizmo = bool
    SetNuiFocus(bool, bool)
end

function DrawText3D(x, y, text,font,scale)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextColor(244, 253, 255, 255)
    SetTextScale(scale,scale)
  	SetTextFontForCurrentCommand(font)--0,1,5,6, 9, 11, 12, 15, 18, 19, 20, 22, 24, 25, 28, 29
    SetTextCentre(1)
    DisplayText(str,x,y)
end

function useGizmo(handle)

    SendNUIMessage({
        action = 'setGizmoEntity',
        data = {
            handle = handle,
            position = GetEntityCoords(handle),
            rotation = GetEntityRotation(handle, 2)
        }
    })

    toggleNuiFrame(true)

    gizmoText = ('Current Mode: %s  \n'):format("translate") ..'[W]    - Translate Mode  \n' ..'[R]    - Rotate Mode  \n' ..'[LALT] - Place On Ground  \n' ..'[Esc]  - Done Editing  \n'

    while usingGizmo do
        print(gizmoText)
        DrawText3D(0.9, 0.7, gizmoText, 1, 0.3)
        SendNUIMessage({
            action = 'setCameraPosition',
            data = {
                position = GetFinalRenderedCamCoord(),
                rotation = GetFinalRenderedCamRot()
            }
        })
        Wait(0)
    end

    return {
        handle = handle,
        position = GetEntityCoords(handle),
        rotation = GetEntityRotation(handle, 2)
    }
end

RegisterNUICallback('moveEntity', function(data, cb)
    local entity = data.handle
    local position = data.position
    local rotation = data.rotation

    SetEntityCoords(entity, position.x, position.y, position.z)
    SetEntityRotation(entity, rotation.x, rotation.y, rotation.z, 2)
    cb('ok')
end)

RegisterNUICallback('placeOnGround', function(data, cb)
    PlaceObjectOnGroundProperly(data.handle)
    cb('ok')
end)

RegisterNUICallback('finishEdit', function(data, cb)
    toggleNuiFrame(false)
    SendNUIMessage({
        action = 'setGizmoEntity',
        data = {
            handle = nil,
        }
    })
    cb('ok')
end)

RegisterNUICallback('swapMode', function(data, cb)
    gizmoText = ('Current Mode: %s  \n'):format(data.mode) .. '[W]    - Translate Mode  \n' ..'[R]    - Rotate Mode  \n' ..'[LALT] - Place On Ground  \n' ..'[Esc]  - Done Editing  \n'
    cb('ok')
end)


exports("useGizmo", useGizmo)
