
GUIEditor = {
    spawn_type_options = {"parkingspot","time", "always"},
    spawn_data_options = {
        ["time"] = {
            "09:00 - 17:00",
            "00:00 - 03:00"
        }
    }
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        GUIEditor.window_editor = guiCreateWindow(1394, 321, 228, 279, "Vehicle Spawnpoint", false)
        guiWindowSetSizable(GUIEditor.window_editor, false)

        GUIEditor.button_create = guiCreateButton(10, 246, 66, 23, "Create", false, GUIEditor.window_editor)
        addEventHandler( "onClientGUIClick", GUIEditor.button_create, function() GUIEditor.Submit() end )
        GUIEditor.combobox_group = guiCreateComboBox(76, 41, 142, 131, "", false, GUIEditor.window_editor)
        for k,v in pairs(vehicles) do
            guiComboBoxAddItem(GUIEditor.combobox_group, k)
        end
        GUIEditor.label_group = guiCreateLabel(10, 45, 56, 15, "Group", false, GUIEditor.window_editor)
        GUIEditor.label_subgroup = guiCreateLabel(10, 78, 56, 15, "Subgroup", false, GUIEditor.window_editor)
        GUIEditor.combobox_subgroup = guiCreateComboBox(76, 74, 142, 195, "", false, GUIEditor.window_editor)
        addEventHandler("onClientGUIComboBoxAccepted", GUIEditor.combobox_group,
            function( combobox )
                guiComboBoxClear(GUIEditor.combobox_subgroup)
                option = guiComboBoxGetItemText( combobox, guiComboBoxGetSelected(combobox))
                for k,v in pairs(vehicles[option]) do
                    guiComboBoxAddItem(GUIEditor.combobox_subgroup, k)
                end 
            end
        )
        GUIEditor.checkbox_lock_rotation = guiCreateCheckBox(10, 221, 208, 15, "Lock rotation", false, false, GUIEditor.window_editor)
        GUIEditor.combobox_spawn_type = guiCreateComboBox(76, 155, 142, 114, "", false, GUIEditor.window_editor)
        for _, v in ipairs(GUIEditor.spawn_type_options) do guiComboBoxAddItem( GUIEditor.combobox_spawn_type, v) end
        GUIEditor.label_spawn_type = guiCreateLabel(10, 156, 56, 15, "Type", false, GUIEditor.window_editor)
        GUIEditor.combobox_spawn_data = guiCreateComboBox(76, 188, 142, 81, "", false, GUIEditor.window_editor)
        GUIEditor.label_spawn_data = guiCreateLabel(10, 190, 56, 15, "Data", false, GUIEditor.window_editor)
        GUIEditor.edit_spawn_data = guiCreateEdit(76, 190, 142, 21, "", false, GUIEditor.window_editor)
        guiSetVisible(GUIEditor.combobox_spawn_data, false)
        guiSetVisible(GUIEditor.edit_spawn_data, false)
        guiSetVisible(GUIEditor.label_spawn_data, false)    
        addEventHandler("onClientGUIComboBoxAccepted", GUIEditor.combobox_spawn_type,
            function( combobox)
                guiComboBoxClear(GUIEditor.combobox_spawn_data)
                option = guiComboBoxGetItemText( combobox, guiComboBoxGetSelected(combobox))
                if option == "time" then
                    guiSetVisible( GUIEditor.label_spawn_data, true )
                    guiSetText( GUIEditor.label_spawn_data, "Time")
                    guiSetVisible( GUIEditor.combobox_spawn_data, false )
                    guiSetVisible( GUIEditor.edit_spawn_data, true)
                    if guiGetText( GUIEditor.edit_spawn_data) == "" then
                        guiSetText( GUIEditor.edit_spawn_data, "09:00-17:00")
                    end
                elseif option == "opties" then
                    for k,v in pairs(spawn_data_options[option]) do
                        guiComboBoxAddItem(GUIEditor.combobox_spawn_data, k)
                    end
                    guiSetVisible(GUIEditor.combobox_spawn_data, true)
                    guiSetText()
                    guiSetVisible(GUIEditor.label_spawn_data, true)
                else
                    guiSetVisible(GUIEditor.combobox_spawn_data, false)
                    guiSetVisible(GUIEditor.edit_spawn_data, false)
                    guiSetVisible(GUIEditor.label_spawn_data, false)  
                end                
            end
        )        
        GUIEditor.button_move_left = guiCreateButton(76, 246, 26, 23, "<", false, GUIEditor.window_editor)
        addEventHandler( "onClientGUIClick", GUIEditor.button_move_left, function() GUIEditor.RequestMove( "left", tonumber(guiGetText(GUIEditor.edit_move_width ) )) end)
        GUIEditor.button_move_right = guiCreateButton(106, 246, 26, 23, ">", false, GUIEditor.window_editor)
        addEventHandler( "onClientGUIClick", GUIEditor.button_move_right, function() GUIEditor.RequestMove( "right", tonumber(guiGetText(GUIEditor.edit_move_width ) )) end)
        GUIEditor.edit_move_width = guiCreateEdit(139, 248, 55, 21, "3.75", false, GUIEditor.window_editor) 
        GUIEditor.button_close = guiCreateButton(204, 246, 14, 23, "x", false, GUIEditor.window_editor)
        addEventHandler( "onClientGUIDoubleClick", GUIEditor.button_close, GUIEditor.Close)
        GUIEditor.label_model = guiCreateLabel(10, 20, 56, 15, "Model(s)", false, GUIEditor.window_editor)
        guiSetFont(GUIEditor.label_model, "default-bold-small")
        GUIEditor.label_spawn = guiCreateLabel(10, 135, 85, 15, "Spawn Options", false, GUIEditor.window_editor)
        guiSetFont(GUIEditor.label_spawn, "default-bold-small")
        --guiComboBoxSetSelected( GUIEditor.combobox_group)
        GUIEditor.Toggle(false)
        bindKey( "F6", "down", function() GUIEditor.Toggle() end)
    end
)

function GUIEditor.Toggle( state )
    if state == nil then state = not guiGetVisible( GUIEditor.window_editor) end
    guiSetVisible( GUIEditor.window_editor, state)
    showCursor(state)
end

function GUIEditor.Submit()
    data = {
        ["group"] = guiComboBoxGetItemText( GUIEditor.combobox_group, guiComboBoxGetSelected( GUIEditor.combobox_group ) ),
        ["subgroup"] = guiComboBoxGetItemText( GUIEditor.combobox_subgroup, guiComboBoxGetSelected( GUIEditor.combobox_subgroup ) ),
        ["spawn_type"] = guiComboBoxGetItemText( GUIEditor.combobox_spawn_type, guiComboBoxGetSelected( GUIEditor.combobox_spawn_type ) ),
        ["lock_rotation"] = guiCheckBoxGetSelected( GUIEditor.checkbox_lock_rotation)
    }
    triggered = triggerServerEvent("onVehicleSpawnpointEditorSubmit", root, data)
    outputDebugString("triggered server event", 1)
end

function GUIEditor.Close()
    GUIEditor.Toggle(false)
end

function GUIEditor.RequestMove(direction, stepsize )
    triggerServerEvent("onEditorRequestMove", root, direction, stepsize)
end

