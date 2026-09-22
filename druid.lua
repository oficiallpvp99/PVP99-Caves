local ropeId = 3003  -- ID da Rope
local useOnSelf = true  -- Variável para usar em você mesmo

corda = macro(1000, function()
  if useOnSelf then
    usewith(ropeId, player)  -- Usa a Rope no personagem
  end
end)

addIcon("Co", {item=3003, text="ropa",}, function(icon, isOn) 
  corda.setOn(isOn) 
end)

local function hideAllIcon()
  for i, child in ipairs(modules.game_interface.gameMapPanel:getChildren()) do
    if child:getStyleName() == "BotIcon" then
      if icon then
        child:hide()
      else
        child:show()
      end
    end
  end
end

hotkey("F2", "Esconder Iconos", function() 
  icon = not icon
  hideAllIcon()
end)


local npcCities = {
  ['King Tibianus'] = {'promotion'},
  ['Stutchs'] = {'Ab\'Dendriel'}
}

local npcs = {
  'King Tibianus',
  'Stutchs'
}


-- Interfaz de usuario
g_ui.loadUIFromString([[
CityTravelWindow < MainWindow
  text: By Pvp99
  size: 110 70

  ComboBox
    id: travelOptions
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    margin-top: 1
    width: 80
    height: 20

  HorizontalSeparator
    id: separator
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: travelOptions.bottom
    margin-top: 5

]])

local panelName = "cityTravel"
if not storage[panelName] then
  storage[panelName] = {
    enabled = false,
  }
end

local config = storage[panelName]

rootWidget = g_ui.getRootWidget()
if rootWidget then
  local cityTravelWindow = UI.createWindow('CityTravelWindow', rootWidget)
  cityTravelWindow:hide()

  for _, npcName in ipairs(npcs) do
    NPC[npcName] = function(text)
        if g_game.getClientVersion() >= 810 then
            g_game.talkChannel(11, 0, text)
        else
            return say(text)
        end
    end
  end

  local function updateTravelOptions(npcName)
    cityTravelWindow:recursiveGetChildById('travelOptions'):clearOptions()
    cityTravelWindow:recursiveGetChildById('travelOptions'):addOption("Comprar")
    if npcCities[npcName] then
      for _, city in ipairs(npcCities[npcName]) do
        cityTravelWindow:recursiveGetChildById('travelOptions'):addOption(city)
      end
    end
  end

  macro(100, function()
    for _, npcName in ipairs(npcs) do
      local findNpc = getCreatureByName(npcName)
      local playerPos = pos()
      if findNpc and getDistanceBetween(playerPos, findNpc:getPosition()) <= 2 then
        updateTravelOptions(npcName)
        cityTravelWindow:show()
        break
      else
        cityTravelWindow:hide()
      end
    end
  end)

  cityTravelWindow:recursiveGetChildById('travelOptions').onOptionChange = function(widget, option, data)
    if option ~= "Comprar" then
      NPC.say('hail king')
      schedule(200, function()  -- 2 seconds delay
        for _, npcName in ipairs(npcs) do
          local findNpc = getCreatureByName(npcName)
          if findNpc and getDistanceBetween(pos(), findNpc:getPosition()) <= 2 then
            NPC[npcName](option)
          end
        end
      end)
      schedule(500, function()  -- 4 seconds delay from the start (2 seconds after the previous command)
        for _, npcName in ipairs(npcs) do
          local findNpc = getCreatureByName(npcName)
          if findNpc and getDistanceBetween(pos(), findNpc:getPosition()) <= 2 then
            NPC[npcName]('yes')
          end
        end
      end)
    end
  end
end

local npcCities = {
  ['Naji'] = {'deposit all',},
  ['Anya'] = {'deposit all',},
  ['Eva'] = {'deposit all',},
  ['Kepar'] = {'deposit all',}
}

local npcs = {
  'Naji',
  'Anya',
  'Eva',
  'Kepar'
}


-- Interfaz de usuario
g_ui.loadUIFromString([[
CityTravelWindow < MainWindow
  text: By Pvp99
  size: 110 70

  ComboBox
    id: travelOptions
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    margin-top: 1
    width: 80
    height: 20

  HorizontalSeparator
    id: separator
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: travelOptions.bottom
    margin-top: 5

]])

local panelName = "cityTravel"
if not storage[panelName] then
  storage[panelName] = {
    enabled = false,
  }
end

local config = storage[panelName]

rootWidget = g_ui.getRootWidget()
if rootWidget then
  local cityTravelWindow = UI.createWindow('CityTravelWindow', rootWidget)
  cityTravelWindow:hide()

  for _, npcName in ipairs(npcs) do
    NPC[npcName] = function(text)
        if g_game.getClientVersion() >= 810 then
            g_game.talkChannel(11, 0, text)
        else
            return say(text)
        end
    end
  end

  local function updateTravelOptions(npcName)
    cityTravelWindow:recursiveGetChildById('travelOptions'):clearOptions()
    cityTravelWindow:recursiveGetChildById('travelOptions'):addOption("Banco")
    if npcCities[npcName] then
      for _, city in ipairs(npcCities[npcName]) do
        cityTravelWindow:recursiveGetChildById('travelOptions'):addOption(city)
      end
    end
  end

  macro(100, function()
    for _, npcName in ipairs(npcs) do
      local findNpc = getCreatureByName(npcName)
      local playerPos = pos()
      if findNpc and getDistanceBetween(playerPos, findNpc:getPosition()) <= 2 then
        updateTravelOptions(npcName)
        cityTravelWindow:show()
        break
      else
        cityTravelWindow:hide()
      end
    end
  end)

  cityTravelWindow:recursiveGetChildById('travelOptions').onOptionChange = function(widget, option, data)
    if option ~= "Banco" then
      NPC.say('hi')
      schedule(200, function()  -- 2 seconds delay
        for _, npcName in ipairs(npcs) do
          local findNpc = getCreatureByName(npcName)
          if findNpc and getDistanceBetween(pos(), findNpc:getPosition()) <= 2 then
            NPC[npcName](option)
          end
        end
      end)
      schedule(500, function()  -- 4 seconds delay from the start (2 seconds after the previous command)
        for _, npcName in ipairs(npcs) do
          local findNpc = getCreatureByName(npcName)
          if findNpc and getDistanceBetween(pos(), findNpc:getPosition()) <= 2 then
            NPC[npcName]('yes')
          end
        end
      end)
    end
  end
end

local npcCities = {
  ['Captain Bluebear'] = {'Carlin', 'Ab\'Dendriel', 'Venore', 'Port Hope', 'Liberty Bay', 'Svargrond', 'Yalahar', 'Roshamuul', 'Oramond', 'Edron', 'Krailos', 'Rangiroa,', 'Arcadia,'},
  ['Captain Greyhound'] = {'Thais', 'Ab\'Dendriel', 'Venore', 'Svargrond', 'Yalahar', 'Edron', 'Arcadia'},
  ['Captain Fearless'] = {'Issavi', 'Thais', 'Carlin', 'Ab\'Dendriel', 'Port Hope', 'Edron', 'Darashia', 'Liberty Bay', 'Svargrond', 'Yalahar', 'Gray Island', 'Ankrahmun', 'Rangiroa', 'Arcadia'},
  ['Captain Seagull'] = {'Thais', 'Carlin', 'Venore', 'Yalahar', 'Edron', 'Gray Island'},
  ['Captain Cookie'] = {'Liberty Bay'},
  ['Jack Fate'] = {'Edron', 'Thais', 'Venore', 'Darashia', 'Ankrahmun', 'Yalahar', 'Port Hope'},
  ['Charles'] = {'Thais', 'Darashia', 'Venore', 'Liberty Bay', 'Ankrahmun', 'Yalahar', 'Edron'},
  ['Karith'] = {'Ab\'Dendriel', 'Darashia', 'Venore', 'Ankrahmun', 'Port Hope', 'Thais', 'Liberty Bay', 'Carlin', 'Arcadia'},
  ['Captain Max'] = {'Calassa', 'Yalahar', 'Liberty Bay'},
  ['Captain Seahorse'] = {'Thais', 'Carlin', 'Ab\'Dendriel', 'Venore', 'Port Hope', 'Ankrahmun', 'Liberty Bay', 'Gray Island', 'Cormaya'},
  ['Pemaret'] = {'Edron', 'Eremo'},
  ['Eremo'] = {'passage'},
  ['Captain Pelagia'] = {'Edron', 'Darashia', 'Oramond', 'Venore', 'Issavi'},
  ['Captain Gulliver'] = {'Thais', 'Krailos'},
  ['Captain Chelop'] = {'Thais'},
  ['Captain Harava'] = {'Oramond', 'Krailos', 'Venore', 'Darashia'},
  ['Captain Grenald'] = {'Carlin', 'Thais', 'Venore', 'Yalahar', 'Svargrond'},
  ['Gurbasch'] = {'Kazordoon', 'Farmine', 'Gnomprona'},
  ['Thorgrin'] = {'Cormaya', 'Kazordoon'},
  ['Brodrosch'] = {'Cormaya', 'Farmine', 'Gnomprona', 'Ticket'},
  ['Melian'] = {'Darashia', 'Femor Hills', 'Svargrond', 'Edron', 'Issavi'},
  ['Chemar'] = {'Farmine', 'Femor Hills', 'Svargrond', 'Edron', 'Issavi', 'Marapur', 'Kazordoon'},
  ['Gewen'] = {'Farmine', 'Femor Hills', 'Svargrond', 'Edron', 'Issavi', 'Marapur', 'Darashia', 'Ticket'},
  ['Uzon'] = {'Farmine', 'Kazordoon', 'Svargrond', 'Edron', 'Issavi', 'Marapur', 'Darashia'},
  ['Tanyt'] = {'Farmine', 'Femor Hills', 'Svargrond', 'Edron', 'Issavi', 'Marapur', 'Darashia', 'Kazordoon', 'Arcadia'},
  ['Alfrida'] = {'Farmine', 'Femor Hills', 'Svargrond', 'Edron', 'Issavi', 'Marapur', 'Darashia',  'Kazordoon'},
  ['Iyad'] = {'Farmine', 'Femor Hills', 'Edron', 'Issavi', 'Marapur', 'Darashia',  'Kazordoon'},
  ['Petros'] = {'Venore', 'Ankrahmun', 'Yalahar', 'Port Hope', 'Issavi', 'Gray Island'},
  ['Captain Sinbeard'] = {'Darashia', 'Yalahar', 'Port Hope', 'Edron', 'Venore', 'Liberty Bay'},
  ['Lorek'] = {'Center', 'West', 'Banuta', 'Chor', 'Darama'},
  ['Imbul'] = {'Centre', 'east'},
  ['Old Adall'] = {'east', 'west'},
  ['Pino'] = {'Farmine', 'Femor Hills', 'Edron', 'Issavi', 'Marapur', 'Darashia',  'Kazordoon'},
  ['Captain Frank'] = {'Venore'},
  ['Captain Breezelda'] = {'Carlin', 'Venore', 'Thais', 'Arcadia'},
  ['Quentin'] = {'twist of fate'},  
  ['Scrutinon'] = {'Ab\'Dendriel', 'Darashia', 'Edron', 'Venore'}
}

local npcs = {
  'Captain Bluebear',
  'Captain Greyhound',
  'Captain Fearless',
  'Captain Seagull',
  'Captain Cookie',
  'Jack Fate',
  'Charles',
  'Karith',
  'Captain Max',
  'Captain Seahorse',
  'Pemaret',
  'Eremo',
  'Captain Pelagia',
  'Captain Gulliver',
  'Captain Chelop',
  'Captain Harava',
  'Captain Grenald',
  'Gurbasch',
  'Thorgrin',
  'Brodrosch',
  'Melian',
  'Chemar',
  'Gewen',
  'Uzon',
  'Tanyt',
  'Alfrida',
  'Iyad',
  'Petros',
  'Captain Sinbeard',
  'Lorek',
  'Imbul',
  'Old Adall',
  'Pino',
  'Captain Frank',
  'Captain Breezelda',
  'Quentin',
  'Scrutinon'
}


-- Interfaz de usuario
g_ui.loadUIFromString([[
CityTravelWindow < MainWindow
  text: By Pvp99
  size: 110 70

  ComboBox
    id: travelOptions
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    margin-top: 1
    width: 80
    height: 20

  HorizontalSeparator
    id: separator
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: travelOptions.bottom
    margin-top: 5

]])

local panelName = "cityTravel"
if not storage[panelName] then
  storage[panelName] = {
    enabled = false,
  }
end

local config = storage[panelName]

rootWidget = g_ui.getRootWidget()
if rootWidget then
  local cityTravelWindow = UI.createWindow('CityTravelWindow', rootWidget)
  cityTravelWindow:hide()

  for _, npcName in ipairs(npcs) do
    NPC[npcName] = function(text)
        if g_game.getClientVersion() >= 810 then
            g_game.talkChannel(11, 0, text)
        else
            return say(text)
        end
    end
  end

  local function updateTravelOptions(npcName)
    cityTravelWindow:recursiveGetChildById('travelOptions'):clearOptions()
    cityTravelWindow:recursiveGetChildById('travelOptions'):addOption("Cidades")
    if npcCities[npcName] then
      for _, city in ipairs(npcCities[npcName]) do
        cityTravelWindow:recursiveGetChildById('travelOptions'):addOption(city)
      end
    end
  end

  macro(100, function()
    for _, npcName in ipairs(npcs) do
      local findNpc = getCreatureByName(npcName)
      local playerPos = pos()
      if findNpc and getDistanceBetween(playerPos, findNpc:getPosition()) <= 2 then
        updateTravelOptions(npcName)
        cityTravelWindow:show()
        break
      else
        cityTravelWindow:hide()
      end
    end
  end)

  cityTravelWindow:recursiveGetChildById('travelOptions').onOptionChange = function(widget, option, data)
    if option ~= "Cidades" then
      say('hi')
      schedule(200, function()  -- 2 seconds delay
        for _, npcName in ipairs(npcs) do
          local findNpc = getCreatureByName(npcName)
          if findNpc and getDistanceBetween(pos(), findNpc:getPosition()) <= 2 then
            NPC[npcName](option)
          end
        end
      end)
      schedule(500, function()  -- 4 seconds delay from the start (2 seconds after the previous command)
        for _, npcName in ipairs(npcs) do
          local findNpc = getCreatureByName(npcName)
          if findNpc and getDistanceBetween(pos(), findNpc:getPosition()) <= 2 then
            NPC[npcName]('yes')
          end
        end
      end)
    end
  end
end

local npcCities = {
  ['Yasir'] = {'sell'},
  ['Sarina'] = {'buy/sell'},
  ['Imalas'] = {'sell'},
  ['Cornelia'] = {'buy/sell'},
  ['Liane'] = {'buy'},
  ['Legola'] = {'buy'},
  ['Nydala'] = {'buy'},
  ['Perac'] = {'buy/sell'},
  ['Rowenna'] = {'buy/sell'},
  ['Florentine'] = {'buy'},
  ['Benjamin'] = {'buy'},
  ['Furry'] = {'buy/sell'},
  ['Urd'] = {'buy/sell'},
  ['Frodo'] = {'buy'},
  ['Quero'] = {'buy'},
  ['Xodet'] = {'buy/sell'},
  ['Hanna'] = {'buy/sell'},
  ['Gorn'] = {'buy'},
  ['Sam'] = {'buy/sell'},
  ['Turvy'] = {'buy/sell'},
  ['Topsy'] = {'buy/sell'},
  ['Gamon'] = {'buy'},
  ['Baxter'] = {'buy/sell'},
  ['Lubo'] = {'buy/sell'},
  ['Enpa-Deia Pema'] = {'buy/sell'},
  ['Zethra'] = {'buy'},
  ['Alesar'] = {'buy/sell'},
  ['Yaman'] = {'buy/sell'},
  ['Rashid'] = {'buy/sell'},
  ['Nah\'Bob'] = {'buy/sell'},
  ['Haroun'] = {'buy/sell'},
  ['Nelliem'] = {'buy'},
  ['Shiantis'] = {'buy/sell'},
  ['Chephan'] = {'buy'},
  ['Julian'] = {'buy'},
  ['Urd'] = {'buy/sell'},
  ['Rachel'] = {'buy/sell'}
}

local npcs = {
  'Yasir',
  'Sarina',
  'Imalas',
  'Cornelia',
  'Liane',
  'Legola',
  'Perac',
  'Rowenna',
  'Nydala',
  'Florentine',
  'Benjamin',
  'Furry',
  'Urd',
  'Frodo',
  'Quero',
  'Xodet',
  'Hanna',
  'Gorn',
  'Sam',
  'Turvy',
  'Topsy',
  'Gamon',
  'Baxter',
  'Lubo',
  'Enpa-Deia Pema',
  'Zethra',
  'Alesar',
  'Yaman',
  'Rashid',
  'Nah\'Bob',
  'Haroun',
  'Nelliem',
  'Shiantis',
  'Chephan',
  'Julian',
  'Urd',
  'Rachel'
}


-- Interfaz de usuario
g_ui.loadUIFromString([[
CityTravelWindow < MainWindow
  text: By Pvp99
  size: 110 70

  ComboBox
    id: travelOptions
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.top
    margin-top: 1
    width: 80
    height: 20

  HorizontalSeparator
    id: separator
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: travelOptions.bottom
    margin-top: 5

]])

local panelName = "trader"
if not storage[panelName] then
  storage[panelName] = {
    enabled = false,
  }
end

local config = storage[panelName]

rootWidget = g_ui.getRootWidget()
if rootWidget then
  local cityTravelWindow = UI.createWindow('CityTravelWindow', rootWidget)
  cityTravelWindow:hide()

  for _, npcName in ipairs(npcs) do
    NPC[npcName] = function(text)
        if g_game.getClientVersion() >= 810 then
            g_game.talkChannel(11, 0, text)
        else
            return say(text)
        end
    end
  end

  local function updateTravelOptions(npcName)
    cityTravelWindow:recursiveGetChildById('travelOptions'):clearOptions()
    cityTravelWindow:recursiveGetChildById('travelOptions'):addOption("Trade")
    if npcCities[npcName] then
      for _, city in ipairs(npcCities[npcName]) do
        cityTravelWindow:recursiveGetChildById('travelOptions'):addOption(city)
      end
    end
  end

  macro(100, function()
    for _, npcName in ipairs(npcs) do
      local findNpc = getCreatureByName(npcName)
      local playerPos = pos()
      if findNpc and getDistanceBetween(playerPos, findNpc:getPosition()) <= 2 then
        updateTravelOptions(npcName)
        cityTravelWindow:show()
        break
      else
        cityTravelWindow:hide()
      end
    end
  end)

  cityTravelWindow:recursiveGetChildById('travelOptions').onOptionChange = function(widget, option, data)
    if option ~= "Trade" then
      say('hi')
      schedule(200, function()  -- 2 seconds delay
        for _, npcName in ipairs(npcs) do
          local findNpc = getCreatureByName(npcName)
          if findNpc and getDistanceBetween(pos(), findNpc:getPosition()) <= 2 then
            NPC[npcName](option)
          end
        end
      end)
      schedule(500, function()  -- 4 seconds delay from the start (2 seconds after the previous command)
        for _, npcName in ipairs(npcs) do
          local findNpc = getCreatureByName(npcName)
          if findNpc and getDistanceBetween(pos(), findNpc:getPosition()) <= 2 then
            NPC[npcName]('trade')
          end
        end
      end)
    end
  end
end


local SpellTab = addTab("Target")
local name = UI.Label("SORCERER")

macro(800, function()
  local rainbowDelay = 0
  for k, color in ipairs({"#9b30ff", "#8629cc", "#712399", "#5c1d66", "#471833", "#330e00"}) do
    schedule(rainbowDelay, function()
      name:setColor(color)
    end)
    rainbowDelay = rainbowDelay + 100 -- tempo entre elas
  end
end)


local SpellsTab = addTab("Target") -- Add new tab called
macro(5000, "Exevo Gran Mas Flam",function()
    if g_game.isAttacking() then
        say("exevo gran mas flam")
    end
end, SpellsTab)

local SpellsTab = addTab("Target") -- Add new tab called
macro(3500, "Exevo Gran Mas vis", function()
    if g_game.isAttacking() then
        say("exevo gran mas vis")
        say("exevo gran mas vis")
        say("exevo gran mas vis")
    end
end, SpellsTab)

local SpellsTab = addTab("Target") -- Add new tab called
macro(4000, "Exori Moe", function()
  if g_game.isAttacking() then
    say("exori Moe")
  end
end, SpellsTab)

local SpellsTab = addTab("Target") -- Add new tab called
macro(2000, "Exevo gran flam hur", function()
  if g_game.isAttacking() then
    say("exevo gran flam hur")
  end
end, SpellsTab)

local SpellsTab = addTab("Target") -- Add new tab called
macro(2000, "Exevo Vis Hur", function()
  if g_game.isAttacking() then
    say("exevo vis hur")
  end
end, SpellsTab)

local SpellsTab = addTab("Target") -- Add new tab called
macro(1000, "Exori Flam", function()
  if g_game.isAttacking() then
    say("exori flam")
  end
end, SpellsTab)

local SpellsTab = addTab("Target") -- Add new tab called
macro(1000, "Exori Vis", function()
  if g_game.isAttacking() then
    say("exori vis")
  end
end, SpellsTab)

local SpellsTab = addTab("Target") -- Add new tab called
macro(1000, "Exori Mort", function()
  if g_game.isAttacking() then
    say("exori mort")
  end
end, SpellsTab)


local SpellTab = addTab("Target")
local name = UI.Label("DRUID")

macro(800, function()
  local rainbowDelay = 0
  for k, color in ipairs({"#00ff00", "#00e600", "#00cc00", "#00b300", "#009900", "#008000"}) do
    schedule(rainbowDelay, function()
      name:setColor(color)
    end)
    rainbowDelay = rainbowDelay + 100 -- tempo entre elas
  end
end)


local SpellsTab = addTab("Target") -- Add new tab called
macro(100, "Exura Sio", function()
    local friend = getPlayerByName(storage.friendName)
    local friend1 = getPlayerByName(storage.friend1Name)
    if friend and friend:getHealthPercent() < 90 then
        say("exura sio \""..storage.friendName)
        delay(500)
   elseif friend1 and friend1:getHealthPercent() <= 91 then -- If u need more you can copy this lines
        say("exura sio \""..storage.friend1Name) --
        delay(500) --
    end -- And paste them between this end and the delay
end, SpellsTab)
  addTextEdit("friendName", storage.friendName or "Friend Name", function(widget, text) 
    storage.friendName = text
end, SpellsTab)
  addTextEdit("friend1Name", storage.friend1Name or "Friend Name", function(widget, text)   -- Also copy this lines
    storage.friend1Name = text -- If u add more just rename the Friend1Name to Friend2Name in the lines u paste
end, SpellsTab)


local SpellsTab = addTab("Target") -- Add new tab called
macro(4000, "Exevo Gran Mas Frigo",function()
    if g_game.isAttacking() then
        say("exevo gran mas frigo")
    end
end, SpellsTab)

local SpellsTab = addTab("Target") -- Add new tab called
macro(2500, "Exevo Gran Mas Tera", function()
    if g_game.isAttacking() then
        say("exevo gran mas tera")
        say("exevo gran mas tera")
        say("exevo gran mas tera")
    end
end, SpellsTab)

local SpellsTab = addTab("Target") -- Add new tab called
macro(2000, "Exevo Frigo Hur", function()
  if g_game.isAttacking() then
    say("exevo frigo hur")
  end
end, SpellsTab)

local SpellsTab = addTab("Target") -- Add new tab called
macro(2000, "Exevo Tera Hur", function()
  if g_game.isAttacking() then
    say("exevo tera hur")
  end
end, SpellsTab)

local SpellsTab = addTab("Target") -- Add new tab called
macro(1000, "Exori Frigo", function()
  if g_game.isAttacking() then
    say("exori frigo")
  end
end, SpellsTab)

local SpellsTab = addTab("Target") -- Add new tab called
macro(1000, "Exori Tera", function()
  if g_game.isAttacking() then
    say("exori tera")
  end
end, SpellsTab)



--TABLA DE RUNAS

local SpellTab = addTab("Target")
local name = UI.Label("RUNAS")

macro(800, function()
  local rainbowDelay = 0
  for k, color in ipairs({"#ffffff", "#f2f2f2", "#e6e6e6", "#d9d9d9", "#cccccc", "#bfbfbf"}) do
    schedule(rainbowDelay, function()
      name:setColor(color)
    end)
    rainbowDelay = rainbowDelay + 100 -- tempo entre elas
  end
end)


local SpellsTab = addTab("Target") -- Add new tab called
macro(400, "Runa Sd ", function()
    if g_game.isAttacking() then
        usewith(3155, g_game.getAttackingCreature())
        delay(1200)
    end
end, SpellsTab)

local SpellsTab = addTab("Target") -- Add new tab called
macro(400, "Runa Avalanche", function()
    if g_game.isAttacking() then
        usewith(3161, g_game.getAttackingCreature())
        delay(1200)
    end
end, SpellsTab)

local SpellsTab = addTab("Target") -- Add new tab called
macro(400, "Runa Great Fireball ", function()
    if g_game.isAttacking() then
        usewith(3191, g_game.getAttackingCreature())
        delay(1200)
    end
end, SpellsTab)

local SpellsTab = addTab("Target") -- Add new tab called
macro(400, "Runa Stone Shower", function()
    if g_game.isAttacking() then
        usewith(3175, g_game.getAttackingCreature())
        delay(1200)
    end
end, SpellsTab)

local SpellsTab = addTab("Target") -- Add new tab called
macro(400, "Runa Thunderstorm", function()
    if g_game.isAttacking() then
        usewith(3202, g_game.getAttackingCreature())
        delay(1200)
    end
end, SpellsTab)

local SpellsTab = addTab("Target") -- Add new tab called
macro(400, "Runa Paralize", function()
    if g_game.isAttacking() then
        usewith(3165, g_game.getAttackingCreature())
        delay(10000)
    end
end, SpellsTab)

local ignoreNames = {
  ["Grovebeast"] = true,
  ["Skullfrost"] = true,
  ["Omniphant"] = true,
  ["Emberwing"] = true,
  ["Thundergiant"] = true
}

atkAll = macro(100, function()
  if not g_game.isOnline() then return end

  -- se já tem target, mantém fixo
  if g_game.getAttackingCreature() then return end

  local myPos = player:getPosition()
  local closest
  local closestDist

  for _, creature in ipairs(getSpectators()) do
    if creature
      and creature:isMonster()
      and not creature:isDead()
      and not creature:isNpc()
      and not creature:isPlayer()
      and creature:getPosition().z == myPos.z
      and not ignoreNames[creature:getName()]
    then
      local dist = getDistanceBetween(myPos, creature:getPosition())

      if not closest or dist < closestDist then
        closest = creature
        closestDist = dist
      end
    end
  end

  if closest then
    attack(closest)
  end
end)

addIcon("AtkAll", { item = 12692, text = "target" }, function(icon, isOn)
  atkAll.setOn(isOn)
end)

local SDId = 3155

SD = macro(500, function()
  if not g_game.isOnline() then return end

  local target = g_game.getAttackingCreature()
  if not target then return end

  useWith(SDId, target)
end)

addIcon("SD", { item = SDId, text = "sd" }, function(icon, isOn)
  SD.setOn(isOn)
end)

local AVAId = 3161

AVA = macro(500, function()
  if not g_game.isOnline() then return end

  local target = g_game.getAttackingCreature()
  if not target then return end

  useWith(AVAId, target)
end)

addIcon("AVA", { item = AVAId, text = "ava" }, function(icon, isOn)
  AVA.setOn(isOn)
end)

local healingSpells = {
  {spell = 'exura vita', threshold = 70},  -- Cura mais forte quando HP for 70% ou menos
  {spell = 'Exura Gran', threshold = 90},  -- Cura intermediária quando HP for 90% ou menos
  {spell = 'Exura', threshold = 94}        -- Cura básica quando HP for 99% ou menos
}

curaru = macro(200, function()
  local currentHp = hppercent()
  
  for _, healing in ipairs(healingSpells) do
    if currentHp <= healing.threshold then
      say(healing.spell)
      break
    end
  end
end)


addIcon("CUR", {item=12809, text="exura",}, function(icon, isOn) 
  curaru.setOn(isOn) 
end)

-- ============================================================
-- DRUID AURERA / TELARIA - V5
-- STANCES + CURA AVANCADA + ROTACAO COMPLETA
--
-- SHARED CONSERVATION = utura sio
-- ELEMENTAL SYNTHESIS = utito dru
--
-- Padrao V5:
-- * sem PNG externo
-- * icones nativos do .dat/.spr
-- * texto fixo nos botoes
-- * verde/vermelho instantaneo no clique
-- * mensagem do servidor sincroniza o estado real depois
-- * rotacao circular
-- * cura propria antes do ataque
-- * Restoration automatica em emergencia (level 300+)
-- * Strong Ice/Terra Strike adicionadas
-- * sem bloqueio por player proximo
-- * rotacao inicia desligada
-- ============================================================

setDefaultTab('MAIN')

storage.druidAureraV5 = storage.druidAureraV5 or {}
local cfg = storage.druidAureraV5

local function default(k, v)
  if cfg[k] == nil then
    cfg[k] = v
  end
end

default('attackGap', 2100)
default('actionGap', 300)

default('autoHeal', true)
default('healAt', 70)
default('healWords', 'exura vita')
default('healMana', 160)
default('healCD', 1000)

default('forkedGlacierOn', true)
default('forkedThornsOn', true)
default('eternalWinterOn', true)
default('wrathNatureOn', true)
default('strongIceWaveOn', true)
default('terraWaveOn', true)
default('ultimateIceOn', true)
default('ultimateTerraOn', true)
default('strongIceStrikeOn', true)
default('strongTerraStrikeOn', true)

-- Cura avançada
default('restorationOn', true)
default('restorationAt', 45)

-- ============================================================
-- ICONES NATIVOS DO CLIENTE
-- Troque somente os IDs se quiser outro visual.
-- ============================================================

local SERVER_ICONS = {
  -- Soulhexer (Druid)
  synthesis = 34091,

  -- Soulshanks (Druid)
  conservation = 34092,

  -- Icone nativo usado no bot/rotacao
  rotation = 47373
}

-- ============================================================
-- ESTADO
-- ============================================================

local function clock()
  return now or g_clock.millis()
end

local stance = 'unknown'
local pending = nil
local pendingAt = 0

local last = {}
local globalNext = 0
local groupNext = {
  attack = 0,
  healing = 0,
  focus = 0,
  special = 0,
  ultimate = 0
}

local icons = {}
local rotation = nil
local attackIndex = 1

-- ============================================================
-- UI
-- ============================================================

local function label(icon, text, color)
  if icon and icon.text then
    icon.text:setText(text)
    icon.text:setColor(color)
  end
end

local function refreshUI()
  label(
    icons.conservation,
    'utura sio',
    stance == 'conservation' and '#55ff55' or '#ff5555'
  )

  label(
    icons.synthesis,
    'utito dru',
    stance == 'synthesis' and '#55ff55' or '#ff5555'
  )

  if icons.rotation and rotation then
    label(
      icons.rotation,
      'atack',
      rotation:isOn() and '#55ff55' or '#ff5555'
    )
  end
end

-- ============================================================
-- TROCA / DESATIVA STANCE
-- Cor muda na hora. Servidor confirma/corrige depois.
-- ============================================================

local function chooseStance(wanted, words)
  if not g_game.isOnline() then
    return
  end

  if pending then
    return
  end

  local togglingOff = (stance == wanted)

  pending = togglingOff and 'off' or wanted
  pendingAt = clock()

  if togglingOff then
    stance = 'unknown'
  else
    stance = wanted
  end

  refreshUI()

  globalNext = math.max(
    globalNext,
    clock() + cfg.actionGap
  )

  say(words)
end

-- ============================================================
-- ICONES DAS STANCES
-- ============================================================

icons.conservation = addIcon(
  'druidAureraConservationV5',
  {
    item = { id = SERVER_ICONS.conservation, count = 1 },
    text = 'utura sio',
    switchable = false,
    moveable = true
  },
  function()
    chooseStance('conservation', 'utura sio')
  end
)

icons.conservation:setSize({
  width = 64,
  height = 64
})

icons.synthesis = addIcon(
  'druidAureraSynthesisV5',
  {
    item = { id = SERVER_ICONS.synthesis, count = 1 },
    text = 'utito dru',
    switchable = false,
    moveable = true
  },
  function()
    chooseStance('synthesis', 'utito dru')
  end
)

icons.synthesis:setSize({
  width = 64,
  height = 64
})

-- ============================================================
-- CONFIRMACAO / SINCRONIZACAO PELO SERVIDOR
-- ============================================================

local function isOffMessage(msg)
  return
    msg:find('deactivated', 1, true)
    or msg:find('disabled', 1, true)
    or msg:find('removed', 1, true)
    or msg:find('ended', 1, true)
end

onTextMessage(function(mode, text)
  local msg = (text or ''):lower()
  local changed = false
  local off = isOffMessage(msg)

  if msg:find('shared conservation', 1, true) then
    if off then
      if stance == 'conservation' then
        stance = 'unknown'
      end
    else
      stance = 'conservation'
    end

    pending = nil
    changed = true

  elseif msg:find('elemental synthesis', 1, true) then
    if off then
      if stance == 'synthesis' then
        stance = 'unknown'
      end
    else
      stance = 'synthesis'
    end

    pending = nil
    changed = true
  end

  if changed then
    refreshUI()
  end
end)

-- ============================================================
-- FAMILIARES / SUMMONS IGNORADOS
-- ============================================================

local ignore = {
  Emberwing = true,
  Skullfrost = true,
  Snowbash = true,
  Grovebeast = true,
  Mossmasher = true,
  Groovebeast = true,
  Thundergiant = true,
  Bladespark = true,
  Sandscourge = true,
  Omniphant = true,
  Moonhunter = true
}

-- ============================================================
-- DISTANCIA / SCAN
-- ============================================================

local function distance(a, b)
  if not a or not b then
    return 999
  end

  if a.z ~= b.z then
    return 999
  end

  return math.max(
    math.abs(a.x - b.x),
    math.abs(a.y - b.y)
  )
end

local function makeSnapshot(p)
  local data = {
    monsters = {}
  }

  for _, creature in ipairs(getSpectators()) do
    local cp = creature:getPosition()

    if cp and cp.z == p.z and creature:getId() ~= player:getId() then
      local d = distance(p, cp)

      if
        creature:isMonster()
        and not ignore[creature:getName()]
      then
        data.monsters[#data.monsters + 1] = d
      end
    end
  end

  return data
end

local function countMonsters(snapshot, range)
  local count = 0

  for _, d in ipairs(snapshot.monsters) do
    if d <= range then
      count = count + 1
    end
  end

  return count
end

-- ============================================================
-- CURA PROPRIA
-- ============================================================

local function tryHeal(time)
  if not cfg.autoHeal then
    return false
  end

  local hp = hppercent()

  if time < groupNext.healing then
    return false
  end

  -- Restoration: cura mais forte do Druid/Sorcerer.
  -- Level 300+, 260 mana, 6s de cooldown.
  if
    cfg.restorationOn
    and lvl() >= 300
    and hp <= cfg.restorationAt
    and mana() >= 260
    and time >= (last['exura max vita'] or 0)
  then
    last['exura max vita'] = time + 6000
    groupNext.healing = time + 1000
    globalNext = time + cfg.actionGap
    say('exura max vita')
    return true
  end

  if hp > cfg.healAt then
    return false
  end

  if mana() < cfg.healMana then
    return false
  end

  if time < (last[cfg.healWords] or 0) then
    return false
  end

  last[cfg.healWords] = time + cfg.healCD
  groupNext.healing = time + 1000
  globalNext = time + cfg.actionGap

  say(cfg.healWords)
  return true
end

-- ============================================================
-- ROTACAO DRUID
-- Circular para passar por gelo e terra.
-- ============================================================

local attackSpells = {

  {
    name = 'Strong Ice Strike',
    words = 'exori gran frigo',
    mana = 60,
    level = 80,
    range = 7,
    mobs = 1,
    cd = 8000,
    groupCD = 2000,
    secondary = 'special',
    secondaryCD = 8000,
    area = false,
    enabled = function()
      return cfg.strongIceStrikeOn
    end
  },

  {
    name = 'Strong Terra Strike',
    words = 'exori gran tera',
    mana = 60,
    level = 70,
    range = 7,
    mobs = 1,
    cd = 8000,
    groupCD = 2000,
    secondary = 'special',
    secondaryCD = 8000,
    area = false,
    enabled = function()
      return cfg.strongTerraStrikeOn
    end
  },

  {
    name = 'Forked Glacier',
    words = 'exevo fur frigo',
    mana = 180,
    level = 90,
    range = 7,
    mobs = 1,
    cd = 6000,
    groupCD = 2000,
    area = true,
    enabled = function()
      return cfg.forkedGlacierOn
    end
  },

  {
    name = 'Forked Thorns',
    words = 'exevo fur tera',
    mana = 180,
    level = 80,
    range = 7,
    mobs = 1,
    cd = 6000,
    groupCD = 2000,
    area = true,
    enabled = function()
      return cfg.forkedThornsOn
    end
  },

  {
    name = 'Eternal Winter',
    words = 'exevo gran mas frigo',
    mana = 1050,
    level = 60,
    range = 7,
    mobs = 2,
    cd = 40000,
    groupCD = 4000,
    secondary = 'focus',
    secondaryCD = 40000,
    area = true,
    enabled = function()
      return cfg.eternalWinterOn
    end
  },

  {
    name = 'Wrath of Nature',
    words = 'exevo gran mas tera',
    mana = 700,
    level = 55,
    range = 7,
    mobs = 2,
    cd = 40000,
    groupCD = 4000,
    secondary = 'focus',
    secondaryCD = 40000,
    area = true,
    enabled = function()
      return cfg.wrathNatureOn
    end
  },

  {
    name = 'Strong Ice Wave',
    words = 'exevo gran frigo hur',
    mana = 170,
    level = 40,
    range = 5,
    mobs = 1,
    cd = 4000,
    groupCD = 2000,
    area = true,
    turning = true,
    enabled = function()
      return cfg.strongIceWaveOn
    end
  },

  {
    name = 'Terra Wave',
    words = 'exevo tera hur',
    mana = 170,
    level = 38,
    range = 5,
    mobs = 1,
    cd = 4000,
    groupCD = 2000,
    area = true,
    turning = true,
    enabled = function()
      return cfg.terraWaveOn
    end
  },

  {
    name = 'Ultimate Ice Strike',
    words = 'exori max frigo',
    mana = 100,
    level = 100,
    range = 7,
    mobs = 1,
    cd = 30000,
    groupCD = 2000,
    secondary = 'ultimate',
    secondaryCD = 30000,
    area = false,
    enabled = function()
      return cfg.ultimateIceOn
    end
  },

  {
    name = 'Ultimate Terra Strike',
    words = 'exori max tera',
    mana = 100,
    level = 90,
    range = 7,
    mobs = 1,
    cd = 30000,
    groupCD = 2000,
    secondary = 'ultimate',
    secondaryCD = 30000,
    area = false,
    enabled = function()
      return cfg.ultimateTerraOn
    end
  }
}

-- ============================================================
-- DIRECAO
-- ============================================================

local function faceTarget(p, tp, time)
  local dx = tp.x - p.x
  local dy = tp.y - p.y

  if dx == 0 and dy == 0 then
    return true
  end

  local direction

  if math.abs(dx) > math.abs(dy) then
    direction = dx > 0 and 1 or 3
  else
    direction = dy > 0 and 2 or 0
  end

  if player:getDirection() ~= direction then
    turn(direction)
    globalNext = time + 150
    return false
  end

  return true
end

-- ============================================================
-- VALIDACAO / CAST
-- ============================================================

local function canCast(spell, time, p, tp, snapshot)
  if spell.enabled and not spell.enabled() then
    return false
  end

  if distance(p, tp) > spell.range then
    return false
  end

  if countMonsters(snapshot, spell.range) < spell.mobs then
    return false
  end

  if mana() < spell.mana then
    return false
  end

  if lvl() < spell.level then
    return false
  end

  if time < (last[spell.words] or 0) then
    return false
  end

  if time < groupNext.attack then
    return false
  end

  if
    spell.secondary
    and time < (groupNext[spell.secondary] or 0)
  then
    return false
  end

  return true
end

local function castCircular(list, time, p, tp, snapshot)
  if #list == 0 then
    return false
  end

  if attackIndex < 1 or attackIndex > #list then
    attackIndex = 1
  end

  for offset = 0, #list - 1 do
    local index = ((attackIndex - 1 + offset) % #list) + 1
    local spell = list[index]

    if canCast(spell, time, p, tp, snapshot) then
      if spell.turning and not faceTarget(p, tp, time) then
        return true
      end

      last[spell.words] = time + spell.cd

      groupNext.attack =
        time + (spell.groupCD or 2000)

      if spell.secondary then
        groupNext[spell.secondary] =
          time + (spell.secondaryCD or 0)
      end

      globalNext = time + cfg.attackGap

      say(spell.words)

      attackIndex = (index % #list) + 1
      return true
    end
  end

  return false
end

-- ============================================================
-- MACRO DA ROTACAO
-- ============================================================

rotation = macro(
  100,
  'Druid Rotacao V5',
  function()
    if not g_game.isOnline() then
      return
    end

    if not player then
      return
    end

    local time = clock()

    if time < globalNext then
      return
    end

    -- Cura tem prioridade.
    if tryHeal(time) then
      return
    end

    local target = g_game.getAttackingCreature()

    if not target or not target:isMonster() then
      return
    end

    local p = player:getPosition()
    local tp = target:getPosition()

    if not p or not tp or p.z ~= tp.z then
      return
    end

    local snapshot = makeSnapshot(p)

    castCircular(
      attackSpells,
      time,
      p,
      tp,
      snapshot
    )
  end
)

rotation.setOff()

-- ============================================================
-- ICONE ATACK
-- ============================================================

icons.rotation = addIcon(
  'druidAureraRotationV5',
  {
    item = { id = SERVER_ICONS.rotation, count = 1 },
    text = 'atack',
    moveable = true
  },
  rotation
)

icons.rotation:setSize({
  width = 64,
  height = 64
})

-- ============================================================
-- LOGIN / LOGOUT / TIMEOUT
-- ============================================================

local wasOnline = g_game.isOnline()

macro(
  250,
  function()
    local online = g_game.isOnline()

    if not online then
      stance = 'unknown'
      pending = nil

      last = {}
      globalNext = 0
      groupNext.attack = 0
      groupNext.healing = 0
      groupNext.focus = 0
      groupNext.special = 0
      groupNext.ultimate = 0
      attackIndex = 1

    elseif not wasOnline then
      -- As stances podem persistir no servidor.
      -- A UI sera sincronizada pelas mensagens futuras.
      pending = nil

      last = {}
      globalNext = 0
      groupNext.attack = 0
      groupNext.healing = 0
      groupNext.focus = 0
      groupNext.special = 0
      groupNext.ultimate = 0
      attackIndex = 1
    end

    wasOnline = online

    if
      pending
      and clock() - pendingAt > 5000
    then
      pending = nil
    end

    refreshUI()
  end
)

-- ============================================================
-- INICIALIZA UI
-- ============================================================

refreshUI()


