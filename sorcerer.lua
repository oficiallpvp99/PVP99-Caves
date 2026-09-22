

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
-- SORCERER AURERA / TELARIA - V5
-- STANCES ELEMENTAIS + CRIPPLING + ROTACAO
--
-- ELEMENTAIS:
-- Master of Flames  = uteta flam
-- Master of Thunder = uteta vis
-- Master of Decay   = uteta mort
--
-- CRIPPLING:
-- Aura of Sapped Strength    = exori kor tempo
-- Aura of Exposed Weakness   = exori moe tempo
--
-- Padrao V5:
-- * sem PNG externo
-- * icones nativos do .dat/.spr
-- * texto fixo nos botoes
-- * verde/vermelho instantaneo no clique
-- * mensagem do servidor sincroniza o estado real depois
-- * elemental e crippling independentes
-- * rotacao circular
-- * rotacao inicia desligada
-- ============================================================

setDefaultTab('MAIN')

storage.sorcererAureraV5 = storage.sorcererAureraV5 or {}
local cfg = storage.sorcererAureraV5

local function default(k, v)
  if cfg[k] == nil then
    cfg[k] = v
  end
end

default('attackGap', 2100)
default('actionGap', 300)

default('deathEchoOn', true)
default('hellsCoreOn', true)
default('rageOn', true)
default('energyWaveOn', true)
default('greatFireWaveOn', true)
default('greatDeathBeamOn', true)

-- ============================================================
-- ICONES NATIVOS DO CLIENTE
-- Troque somente os IDs se quiser outro visual.
-- ============================================================

local SERVER_ICONS = {
  flames = 34090,
  thunder = 34095,
  decay = 34096,
  sapped = 34091,
  exposed = 34094,
  rotation = 47372
}

-- ============================================================
-- ESTADO
-- ============================================================

local function clock()
  return now or g_clock.millis()
end

local elemental = 'unknown'
local crippling = 'unknown'

local elementalPending = nil
local elementalPendingAt = 0

local cripplingPending = nil
local cripplingPendingAt = 0

local last = {}
local globalNext = 0
local focusNext = 0 -- Rage of the Skies + Hell's Core compartilham Focus CD de 40s

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
    icons.flames,
    'uteta flam',
    elemental == 'flames' and '#55ff55' or '#ff5555'
  )

  label(
    icons.thunder,
    'uteta vis',
    elemental == 'thunder' and '#55ff55' or '#ff5555'
  )

  label(
    icons.decay,
    'uteta mort',
    elemental == 'decay' and '#55ff55' or '#ff5555'
  )

  label(
    icons.sapped,
    'exori kor tempo',
    crippling == 'sapped' and '#55ff55' or '#ff5555'
  )

  label(
    icons.exposed,
    'exori moe tempo',
    crippling == 'exposed' and '#55ff55' or '#ff5555'
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
-- TROCA / DESATIVA ELEMENTAL
-- Cor muda na hora. Servidor confirma/corrige depois.
-- ============================================================

local function chooseElemental(wanted, words)
  if not g_game.isOnline() then
    return
  end

  if elementalPending then
    return
  end

  local togglingOff = (elemental == wanted)

  elementalPending = togglingOff and 'off' or wanted
  elementalPendingAt = clock()

  if togglingOff then
    elemental = 'unknown'
  else
    elemental = wanted
  end

  refreshUI()

  globalNext = math.max(
    globalNext,
    clock() + cfg.actionGap
  )

  say(words)
end

-- ============================================================
-- TROCA / DESATIVA CRIPPLING
-- Independente da stance elemental.
-- ============================================================

local function chooseCrippling(wanted, words)
  if not g_game.isOnline() then
    return
  end

  if cripplingPending then
    return
  end

  local togglingOff = (crippling == wanted)

  cripplingPending = togglingOff and 'off' or wanted
  cripplingPendingAt = clock()

  if togglingOff then
    crippling = 'unknown'
  else
    crippling = wanted
  end

  refreshUI()

  globalNext = math.max(
    globalNext,
    clock() + cfg.actionGap
  )

  say(words)
end

-- ============================================================
-- ICONES ELEMENTAIS
-- ============================================================

icons.flames = addIcon(
  'sorcAureraFlamesV5',
  {
    item = { id = SERVER_ICONS.flames, count = 1 },
    text = 'uteta flam',
    switchable = false,
    moveable = true
  },
  function()
    chooseElemental('flames', 'uteta flam')
  end
)

icons.flames:setSize({width = 64, height = 64})

icons.thunder = addIcon(
  'sorcAureraThunderV5',
  {
    item = { id = SERVER_ICONS.thunder, count = 1 },
    text = 'uteta vis',
    switchable = false,
    moveable = true
  },
  function()
    chooseElemental('thunder', 'uteta vis')
  end
)

icons.thunder:setSize({width = 64, height = 64})

icons.decay = addIcon(
  'sorcAureraDecayV5',
  {
    item = { id = SERVER_ICONS.decay, count = 1 },
    text = 'uteta mort',
    switchable = false,
    moveable = true
  },
  function()
    chooseElemental('decay', 'uteta mort')
  end
)

icons.decay:setSize({width = 64, height = 64})

-- ============================================================
-- ICONES CRIPPLING
-- ============================================================

icons.sapped = addIcon(
  'sorcAureraSappedV5',
  {
    item = { id = SERVER_ICONS.sapped, count = 1 },
    text = 'exori kor tempo',
    switchable = false,
    moveable = true
  },
  function()
    chooseCrippling('sapped', 'exori kor tempo')
  end
)

icons.sapped:setSize({width = 64, height = 64})

icons.exposed = addIcon(
  'sorcAureraExposedV5',
  {
    item = { id = SERVER_ICONS.exposed, count = 1 },
    text = 'exori moe tempo',
    switchable = false,
    moveable = true
  },
  function()
    chooseCrippling('exposed', 'exori moe tempo')
  end
)

icons.exposed:setSize({width = 64, height = 64})

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

  -- ELEMENTAIS
  if msg:find('master of flames', 1, true) then
    if off then
      if elemental == 'flames' then
        elemental = 'unknown'
      end
    else
      elemental = 'flames'
    end
    elementalPending = nil
    changed = true

  elseif msg:find('master of thunder', 1, true) then
    if off then
      if elemental == 'thunder' then
        elemental = 'unknown'
      end
    else
      elemental = 'thunder'
    end
    elementalPending = nil
    changed = true

  elseif msg:find('master of decay', 1, true) then
    if off then
      if elemental == 'decay' then
        elemental = 'unknown'
      end
    else
      elemental = 'decay'
    end
    elementalPending = nil
    changed = true
  end

  -- CRIPPLING
  if msg:find('aura of sapped strength', 1, true) then
    if off then
      if crippling == 'sapped' then
        crippling = 'unknown'
      end
    else
      crippling = 'sapped'
    end
    cripplingPending = nil
    changed = true

  elseif msg:find('aura of exposed weakness', 1, true) then
    if off then
      if crippling == 'exposed' then
        crippling = 'unknown'
      end
    else
      crippling = 'exposed'
    end
    cripplingPending = nil
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
-- ROTACAO SORCERER
-- Circular para nao ficar presa sempre na primeira magia.
-- ============================================================

local attackSpells = {
  {
    name = 'Death Echo',
    words = 'exevo mort ora',
    mana = 150,
    level = 120,
    range = 7,
    mobs = 1,
    cd = 6000,
    area = true,
    enabled = function()
      return cfg.deathEchoOn
    end
  },

  {
    name = 'Rage of the Skies',
    words = 'exevo gran mas vis',
    mana = 600,
    level = 55,
    range = 7,
    mobs = 2,
    cd = 40000,
    area = true,
    focus = true,
    enabled = function()
      return cfg.rageOn
    end
  },

  {
    name = 'Hells Core',
    words = 'exevo gran mas flam',
    mana = 1100,
    level = 60,
    range = 7,
    mobs = 2,
    cd = 40000,
    area = true,
    focus = true,
    enabled = function()
      return cfg.hellsCoreOn
    end
  },

  {
    name = 'Energy Wave',
    words = 'exevo vis hur',
    mana = 170,
    level = 38,
    range = 5,
    mobs = 1,
    cd = 8000,
    area = true,
    turning = true,
    enabled = function()
      return cfg.energyWaveOn
    end
  },

  {
    name = 'Great Fire Wave',
    words = 'exevo gran flam hur',
    mana = 120,
    level = 38,
    range = 5,
    mobs = 1,
    cd = 4000,
    area = true,
    turning = true,
    enabled = function()
      return cfg.greatFireWaveOn
    end
  },

  {
    name = 'Great Death Beam',
    words = 'exevo max mort',
    mana = 140,
    level = 66,
    range = 6,
    mobs = 1,
    cd = 6000,
    area = true,
    turning = true,
    enabled = function()
      return cfg.greatDeathBeamOn
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

  if spell.focus and time < focusNext then
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
      globalNext = time + cfg.attackGap

      if spell.focus then
        focusNext = time + 40000
      end

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
  'Sorcerer Rotacao V5',
  function()
    if not g_game.isOnline() then
      return
    end

    if not player then
      return
    end

    if clock() < globalNext then
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

    local time = clock()
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
  'sorcAureraRotationV5',
  {
    item = { id = SERVER_ICONS.rotation, count = 1 },
    text = 'atack',
    moveable = true
  },
  rotation
)

icons.rotation:setSize({width = 64, height = 64})

-- ============================================================
-- LOGIN / LOGOUT / TIMEOUT
-- ============================================================

local wasOnline = g_game.isOnline()

macro(
  250,
  function()
    local online = g_game.isOnline()

    if not online then
      elemental = 'unknown'
      crippling = 'unknown'

      elementalPending = nil
      cripplingPending = nil

      last = {}
      globalNext = 0
      focusNext = 0
      attackIndex = 1

    elseif not wasOnline then
      -- As stances podem persistir no servidor.
      -- O macro aguarda mensagens futuras para sincronizar.
      elementalPending = nil
      cripplingPending = nil

      last = {}
      globalNext = 0
      focusNext = 0
      attackIndex = 1
    end

    wasOnline = online

    if
      elementalPending
      and clock() - elementalPendingAt > 5000
    then
      elementalPending = nil
    end

    if
      cripplingPending
      and clock() - cripplingPendingAt > 5000
    then
      cripplingPending = nil
    end

    refreshUI()
  end
)

-- ============================================================
-- INICIALIZA
-- ============================================================

refreshUI()

-- V5 Sorcerer:
-- 1 elemental + 1 crippling podem ficar verdes simultaneamente.
-- Clique = feedback instantaneo.
-- Mensagem do servidor = sincronizacao posterior.
-- Death Echo incluida na rotacao.


