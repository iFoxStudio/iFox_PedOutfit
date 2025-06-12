local config = require 'config'

local Human = { -- Coloque os peds que não poderão acessar o comando ped mala aqui, isso faz com que somente peds possam usar
    [`mp_m_freemode_01`] = true,
    [`mp_f_freemode_01`] = true, 
}

RegisterCommand('pedmala', function(source, args, raw)
    local ped = PlayerPedId()
    local hashPed = GetEntityModel(ped)
    if Human[hashPed] then
        lib.notify({
            title = config.notify.no_ped_title,
            description = config.notify.no_ped,
            type = 'error'
        })
        return
    end
    local hasItem = lib.callback.await('iFox_PedOutfit:GetPlayerHasClothBag', false, config.item)
    if not hasItem then
        lib.notify({
            title = config.notify.no_bag_title,
            description = config.notify.no_bag,
            type = 'error'
        })
        return
    end
    OpenMenu()
end)

function OpenMenu()
    local mainMenuID = "illenium_appearance_main_menu"
    local mainMenu = {
        id = mainMenuID
    }
    local menuItems = {}


    local changeOutfitMenuID = "illenium_appearance_change_outfit_menu"

    local outfitMenuItems = {
        {
            title = config.menu.title,
            description = config.menu.description,
            menu = changeOutfitMenuID
        }
    }
    mainMenu.title = config.menu.mainMenu
    for i = 0, #outfitMenuItems, 1 do
        menuItems[#menuItems + 1] = outfitMenuItems[i]
    end
    mainMenu.options = menuItems

    lib.registerContext(mainMenu)
    lib.showContext(mainMenuID)
end