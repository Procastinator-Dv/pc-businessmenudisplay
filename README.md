PC-Businessmenucards
PC-Businessmenucards is a FiveM script that allows server owners to create interactive business menus with NPCs or props. Each business can have a unique menu, and players can interact with NPCs or props to view the business menu and make purchases.

Features:
Fully configurable for businesses, NPCs, or props.
Display custom menu images for each business.
Interaction using qb-target for easy configuration.
Option to use either ped (NPC) or prop for business interactions.
Server console message on script load with version info.
Installation:
 I: Download and Install:
      1. Download or clone the repository to your server.
      2. Place the pc-businessmenucards folder into your resources directory.
II: Edit Config:
      1. Navigate to config.lua and configure your businesses:
          a. Set business name, coordinates, and menu image for each business.
          b. Choose whether to use a ped (NPC) or prop for interaction.
III: Add to server.cfg:
      1. Add start pc-businessmenucards to your server.cfg to load the script.
IV: Restart the Server:
      1. Restart your FiveM server to load the script.



      Example Config:
Config.Businesses = {
    uwu_cafe = {
        usePed = true,  -- Use NPC instead of prop
        pedModel = 'a_m_m_business_01',  -- NPC model
        coords = vector3(100.0, -100.0, 29.0),  -- NPC spawn coordinates
        menuImage = 'uwu.png'  -- Menu image for the business
    },
    another_business = {
        usePed = false,  -- Use prop
        propModel = 'prop_bench_01',  -- Prop model
        propCoords = vector3(200.0, -200.0, 29.0),  -- Prop coordinates
        menuImage = 'business_menu.png'  -- Menu image for the business
    }
}


Customization:
  1. Ped vs. Prop: Choose whether each business uses an NPC (ped) or a prop by setting usePed to true or false in the config.
  2. Menu Image: Set the menuImage value to the file name of the image you want to display in the menu.
  3. Interaction: Configure interaction with the NPC/prop using qb-target.
     
Usage:
  1. When a player interacts with the NPC/prop, the corresponding menu image will be shown in an NUI window.
  2. Players can close the menu by pressing the "Escape" key.

     Credits:
Script developed by Procastinator.
