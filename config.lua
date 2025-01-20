
Config = {}

Config.Businesses = {
    ["uwu_cafe"] = {
        name = "UwU Cafe",
        usePed = true, -- Change this to false if you want to use a prop
        pedModel = "a_m_m_business_01",  -- Replace with the desired ped model
        coords = vector3(-585.84, -1063.62, 21.34),  -- Replace with the actual coordinates
        menuImage = "uwu.png",  -- The image file in the html folder
        propModel = "prop_bahammenu",  -- Prop model to be used if usePed is false
        propCoords = vector3(-585.84, -1063.62, 21.34),  -- Prop location
    },

    -- For Adding more Businesses follow the below method
  --[[   ["burger_shot"] = {
        name = "BurgerShot",
        usePed = true,  -- Change this to false if you want to use a prop
        pedModel = 'a_m_m_business_01',  -- Example ped model
        coords = vector3(123.0, -456.0, 78.0),  -- Ped location
        menuImage = "uwu.png",  -- Image for the menu
        propModel = "prop_bahammenu",  -- Prop model to be used if usePed is false
        propCoords = vector3(124.0, -455.0, 78.0),  -- Prop location
    }, ]]
    -- Add more businesses as needed
}
